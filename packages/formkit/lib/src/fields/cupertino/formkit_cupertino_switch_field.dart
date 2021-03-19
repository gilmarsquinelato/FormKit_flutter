import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:formkit/formkit.dart';

/// A FormKit [CupertinoSwitch] wrapper
///
/// {@tool snippet}
/// ```dart
/// FormKitCupertinoSwitchField(
///   name: 'remember',
///   prefix: SizedBox(width: 120, child: Text('Remember me')),
/// )
/// ```
/// {@end-tool}
class FormKitCupertinoSwitchField extends StatefulWidget {
  const FormKitCupertinoSwitchField({
    Key? key,
    required this.name,
    this.validator,
    this.validatorInterval,
    this.validatorTimerMode,

    ///#region [CupertinoFormRow] properties
    this.prefix,
    this.helper,

    ///#endregion

    ///#region [CupertinoSwitch] properties
    this.onChanged,
    this.activeColor,
    this.dragStartBehavior = DragStartBehavior.start,
    this.trackColor,

    ///#endregion
  }) : super(key: key);

  /// {@macro formkit.fields.formKitField.name}
  final String name;

  /// {@macro formkit.fields.formKitField.validator}
  final FormKitValidator<bool>? validator;

  /// {@macro formkit.fields.formKitField.validatorInterval}
  final Duration? validatorInterval;

  /// {@macro formkit.fields.formKitField.validatorTimerMode}
  final ValidatorTimerMode? validatorTimerMode;

  ///#region [CupertinoFormRow] properties

  /// A widget that is displayed at the start of the row.
  ///
  /// The [prefix] parameter is displayed at the start of the row. Standard iOS
  /// guidelines encourage passing a [Text] widget to [prefix] to detail the
  /// nature of the row's [child] widget. If null, the [child] widget will take
  /// up all horizontal space in the row.
  final Widget? prefix;

  /// A widget that is displayed underneath the [prefix] and [child] widgets.
  ///
  /// The [helper] appears in primary label coloring, and is meant to inform the
  /// user about interaction with the child widget. The row becomes taller in
  /// order to display the [helper] widget underneath [prefix] and [child]. If
  /// null, the row is shorter.
  final Widget? helper;

  ///#endregion

  ///#region [CupertinoSwitch] properties

  /// Called when the user toggles with switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  ///
  /// If null, the switch will be displayed as disabled, which has a reduced opacity.
  ///
  /// The callback provided to onChanged should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// CupertinoSwitch(
  ///   value: _giveVerse,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _giveVerse = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool>? onChanged;

  /// The color to use when this switch is on.
  ///
  /// Defaults to [CupertinoColors.systemGreen] when null and ignores
  /// the [CupertinoTheme] in accordance to native iOS behavior.
  final Color? activeColor;

  /// The color to use for the background when the switch is off.
  ///
  /// Defaults to [CupertinoColors.secondarySystemFill] when null.
  final Color? trackColor;

  /// {@macro flutter.cupertino.CupertinoSwitch.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  ///#endregion

  @override
  _FormKitCupertinoSwitchFieldState createState() =>
      _FormKitCupertinoSwitchFieldState();
}

class _FormKitCupertinoSwitchFieldState
    extends State<FormKitCupertinoSwitchField> {
  bool _value = false;

  // bool get _enabled => widget.enabled ?? FormKit.of(context).widget.enabled;

  void _setValue(dynamic? value) {
    _value = value == true;
  }

  @override
  Widget build(BuildContext context) {
    return FormKitField<bool>(
      name: widget.name,
      onSetValue: _setValue,
      validator: widget.validator,
      validatorInterval: widget.validatorInterval,
      validatorTimerMode: widget.validatorTimerMode,
      builder: (onChanged, validationState) {
        final handleChange = (bool value) {
          setState(() {
            _setValue(value);
          });
          onChanged(value);
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        };

        final error =
            validationState.error != null ? Text(validationState.error!) : null;

        return CupertinoFormRow(
          error: error,
          prefix: widget.prefix,
          helper: widget.helper,
          // reduced vertical padding to have the same size across all fields
          padding: const EdgeInsetsDirectional.fromSTEB(20.0, 2.0, 6.0, 2.0),
          child: CupertinoSwitch(
            value: _value,
            onChanged: handleChange,
            activeColor: widget.activeColor,
            trackColor: widget.trackColor,
            dragStartBehavior: widget.dragStartBehavior,
          ),
        );
      },
    );
  }
}
