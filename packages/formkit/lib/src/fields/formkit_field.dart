import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:formkit/formkit.dart';
import 'package:rxdart/rxdart.dart';

/// The base widget to create a [FormKit] field
///
/// An example of how to create a new [FormKit] field
/// For a complete example take a look intto [FormKitTextField]
/// ```dart
/// FormKitField<String>(
///   name: name,
///   onSetValue: onSetValue,
///   validator: validator,
///   validatorInterval: validatorInterval,
///   validatorTimerMode: validatorTimerMode,
///   builder: (onChanged, validationState) {
///     return TextField(
///       onChanged: onChanged,
///     );
///   }
/// )
/// ```
class FormKitField<T> extends StatefulWidget {
  const FormKitField({
    Key? key,
    required this.name,
    required this.builder,
    required this.onSetValue,
    this.validator,
    this.validatorInterval,
    this.validatorTimerMode,
  }) : super(key: key);

  /// {@template formkit.fields.formKitField.name}
  /// Field name so it can be used in [FormKit] widget
  /// {@endtemplate}
  final String name;

  /// Builder to create the field widget
  final FormKitFieldBuilder<T> builder;

  /// When a new value is set by the parent [FormKit]
  final ValueChanged<T?> onSetValue;

  /// {@template formkit.fields.formKitField.validator}
  /// Validator function.
  ///
  /// To define multiple validators use [FormKitValidatorComposer]
  /// {@endtemplate}
  final FormKitValidator<T>? validator;

  /// {@template formkit.fields.formKitField.validatorInterval}
  /// The interval to apply in the timer function,
  /// the default value is [const Duration(milliseconds: 250)].
  /// {@endtemplate}
  final Duration? validatorInterval;

  /// {@template formkit.fields.formKitField.validatorTimerMode}
  /// Timer function to apply into the validation pipeline.
  ///
  /// This mode will be considered when the field value changes
  /// and when [FormKit] calls [FormKitFieldState<T>.setValue].
  /// {@endtemplate}
  final ValidatorTimerMode? validatorTimerMode;

  @override
  FormKitFieldState<T> createState() => FormKitFieldState<T>();
}

class FormKitFieldState<T> extends State<FormKitField<T>> {
  String get name => widget.name;

  BehaviorSubject<T?>? _validator;
  BehaviorSubject<ValidationState>? _validatorResult;
  StreamSubscription<T?>? _validationSubscription;

  Duration get _effectiveTimerInterval =>
      widget.validatorInterval ??
      FormKit.of(context).widget.validatorInterval ??
      const Duration(milliseconds: 250);

  ValidatorTimerMode get _effectiveValidatorTimerMode =>
      widget.validatorTimerMode ??
      FormKit.of(context).widget.validatorTimerMode ??
      ValidatorTimerMode.none;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createValidatorStreams();
  }

  @override
  void dispose() {
    _closeStreams();
    super.dispose();
  }

  @override
  void deactivate() {
    FormKit.of(context).unregister(this);
    super.deactivate();
  }

  @override
  void didUpdateWidget(FormKitField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.validatorTimerMode != widget.validatorTimerMode ||
        oldWidget.validatorInterval != widget.validatorInterval) {
      createValidatorStreams();
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKit = FormKit.of(context);
    formKit.register(this);
    if (widget.validator != null) {
      formKit.setFieldDependencies(this, widget.validator!.fieldDependencies);
    }

    return StreamBuilder<ValidationState>(
      stream: _validatorResult,
      initialData: ValidationState(error: null, isValidating: false),
      builder: (context, snapshot) {
        return widget.builder(
          onChanged,
          snapshot.data!,
        );
      },
    );
  }

  void setValue(T? value) {
    widget.onSetValue(value);

    final formKit = FormKit.of(context);
    final autovalidateMode = formKit.widget.autovalidateMode;
    if (autovalidateMode == AutovalidateMode.always) {
      enqueueValidation(value);
    }
  }

  void onChanged(T? value) {
    final formKit = FormKit.of(context);

    formKit.onFieldChanged(this, value);

    final autovalidateMode = formKit.widget.autovalidateMode;
    if (autovalidateMode == AutovalidateMode.onUserInteraction ||
        autovalidateMode == AutovalidateMode.always) {
      enqueueValidation(value);
    }
  }

  /// Enqueue a new validation through the validation stream
  /// respecting [ValidatorTimerMode].
  void enqueueValidation(T? value) {
    _validator!.add(value);
  }

  /// Does the field validation process.
  ///
  /// Since this is an external call, it wouldn't pass through through the validation stream.
  /// So the [_validatorResult] will have the validation data added here.
  Future<String?> validate(T? value, [Map<String, dynamic>? formValues]) async {
    if (widget.validator == null) {
      return null;
    }

    _validatorResult!.add(ValidationState(error: null, isValidating: true));

    final values = formValues ?? FormKit.of(context).values;
    final error = await widget.validator!.validate(value, values);

    _validatorResult!.add(ValidationState(error: error, isValidating: false));

    return error;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<String>('name', widget.name));
    properties.add(DiagnosticsProperty<FormKitValidator<T>>(
        'validator', widget.validator));
    properties.add(DiagnosticsProperty<Duration>(
        'validatorInterval', widget.validatorInterval));
    properties.add(DiagnosticsProperty<ValidatorTimerMode>(
        'validatorTimerMode', widget.validatorTimerMode));
  }

  void _closeStreams() {
    _validationSubscription?.cancel();
    _validator?.close();
    _validatorResult?.close();
  }

  @internal
  void createValidatorStreams() {
    _closeStreams();

    /// This way makes possible to add [ValidationState] in multiple ways
    /// from internal changes or external calls
    /// like field value changes and [FormKitState.validate] calls.
    _validator = BehaviorSubject<T?>();
    _validatorResult = BehaviorSubject<ValidationState>();

    /// Pipe [_validator] to a backpressure stream based on [ValidatorTimerMode]
    /// then performs the validation.
    _validationSubscription =
        _getTimerModeStream(_validator!, _effectiveValidatorTimerMode)
            .listen(_validate);
  }

  Future<void> _validate(T? value) async {
    final error = await validate(value);
    FormKit.of(context).onFieldValidated(name, error);
  }

  Stream<T?> _getTimerModeStream(
      Stream<T?> stream, ValidatorTimerMode timerMode) {
    switch (timerMode) {
      case ValidatorTimerMode.throttle:
        return stream.throttleTime(_effectiveTimerInterval);
      case ValidatorTimerMode.debounce:
        return stream.debounceTime(_effectiveTimerInterval);
      default:
        return stream;
    }
  }
}

typedef FormKitFieldBuilder<T> = Widget Function(
  /// When the field has changed its value.
  ValueChanged<T> onChanged,

  /// The current validation state.
  ValidationState validationState,
);

@immutable
class ValidationState {
  final String? error;
  final bool isValidating;

  ValidationState({this.error, this.isValidating = false});

  @override
  String toString() {
    return 'ValidationState(error: $error, isValidating: $isValidating)';
  }
}

enum ValidatorTimerMode {
  none,
  throttle,
  debounce,
}
