import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:formkit/formkit.dart';

/// The form widget for FormKit
///
/// It allows us to have a few functions that makes it easier to deal with
/// Like set all fields values with a single function call
/// Validate, save and retrieve the form without having to maintain each field state
///
/// {@tool snippet}
/// A basic widget
///
/// ```dart
/// FormKit(
///   child: Column(
///     children: [
///       FormKitTextField(
///         name: 'email',
///         decoration: InputDecoration(
///           labelText: 'Email',
///         ),
///       ),
///     ]
///   ),
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
/// Controlling [FormKit]
/// In the following example the email field is filled right after the first build was called
/// Setting its value to `some@email.com`
///
/// ```dart
/// class UpdateProfile extends StatefulWidget {
///   @override
///   _UpdateProfileState createState() => _UpdateProfileState();
/// }
///
/// class _UpdateProfileState extends State<UpdateProfile> {
///   final formKey = GlobalKey<FormKitState>();
///
///   @override
///   void initState() {
///     super.initState();
///
///     WidgetsBinding.instance.addPostFrameCallback((_) {
///       formKey.currentState.setValues({
///         'email': 'some@email.com',
///       });
///     });
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return FormKit(
///       key: formKey,
///       child: Column(
///         children: [
///           FormKitTextField(
///             name: 'email',
///             decoration: InputDecoration(
///               labelText: 'Email',
///             ),
///           )
///         ],
///       ),
///     );
///   }
/// }
/// ```
/// {@end-tool}
///
/// {@tool snippet}
/// It's possible to get the instance of [FormKit] via context as well
///
/// ```dart
/// FormKit.of(context)
/// ```
/// {@end-tool}
///
class FormKit extends StatefulWidget {
  const FormKit({
    Key? key,
    required this.child,
    this.initialValues = const {},
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onWillPop,
    this.validatorTimerMode,
    this.validatorInterval,
    this.onSubmit,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// This is the root of the widget hierarchy that contains this form.
  final Widget child;

  /// The initial values for each field under this form.
  ///
  /// Where the key is the field name with the reqpective field value as its value.
  final Map<String, dynamic?>? initialValues;

  /// Used to enable/disable form fields auto validation and update their error
  /// text.
  final AutovalidateMode autovalidateMode;

  /// {@macro formkit.fields.formKitField.validatorInterval}
  ///
  /// Defining [validatorInterval] in the form
  /// will make the fields use this value as default
  /// unless it's specified in the field properties
  /// overriding this value on the specific field.
  final Duration? validatorInterval;

  /// {@macro formkit.fields.formKitField.validatorTimerMode}
  ///
  /// Defining [validatorTimerMode] in the form
  /// will make the fields use this value as default
  /// unless it's specified in the field properties
  /// overriding this value on the specific field.
  final ValidatorTimerMode? validatorTimerMode;

  final Function(Map<String, dynamic?> values)? onSubmit;

  /// Enables the form to veto attempts by the user to dismiss the [ModalRoute]
  /// that contains the form.
  ///
  /// If the callback returns a Future that resolves to false, the form's route
  /// will not be popped.
  ///
  /// See also:
  ///
  ///  * [WillPopScope], another widget that provides a way to intercept the
  ///    back button.
  final WillPopCallback? onWillPop;

  static FormKitState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_FormKitScope>();
    if (scope != null) {
      return scope._formState;
    }

    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
          'FormKit.of() called with a context that does not contain a FormKit.'),
      ErrorHint(
          'The FormKit fields must be put as children of the FormKit widget'),
    ]);
  }

  @override
  FormKitState createState() => FormKitState();
}

class FormKitState extends State<FormKit> {
  int _generation = 0;

  final _fields = Set<FormKitFieldState>();
  final _values = Map<String, dynamic?>();
  final _errors = Map<String, String?>();
  final _fieldDependencies = Map<FormKitFieldState, Set<String>>();
  final _dirtyFields = Set<FormKitFieldState>();

  @override
  void initState() {
    super.initState();

    if (widget.initialValues != null) {
      _values.addAll(widget.initialValues!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.autovalidateMode == AutovalidateMode.always) {
      enqueueValidation();
    }

    return WillPopScope(
      onWillPop: widget.onWillPop,
      child: _FormKitScope(
        formState: this,
        generation: _generation,
        child: widget.child,
      ),
    );
  }

  @override
  void didUpdateWidget(FormKit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.validatorTimerMode != widget.validatorTimerMode ||
        oldWidget.validatorInterval != widget.validatorInterval) {
      _fields.forEach((field) => field.createValidatorStreams());
    }

    _updateFromInitialValues(oldWidget);
  }

  /// {@template formkit.formKit.submit}
  /// This method calls the [validate] function,
  /// if any error was found, it returns null,
  /// otherwise it will call the [FormKit.onSubmit] callback
  /// and return the current form values.
  /// {@endtemplate}
  Future<Map<String, dynamic>?> submit() async {
    await validate();
    if (hasErrors) {
      return null;
    }

    if (widget.onSubmit != null) {
      widget.onSubmit!(values);
    }

    return values;
  }

  /// {@template formkit.formKit.values}
  /// Returns the current values of the form
  /// {@endtemplate}
  Map<String, dynamic?> get values => {..._values};

  /// {@template formkit.formKit.setValues}
  /// Set the given values of the form fields based on their names
  /// {@endtemplate}
  void setValues(Map<String, dynamic?> values) {
    _values.addAll(values);

    for (final field in _fields) {
      field.setValue(values[field.name]);
    }

    _forceUpdate();
  }

  /// {@template formkit.formKit.hasErrors}
  /// Indicates if the form has fields with errors
  /// {@endtemplate}
  bool get hasErrors =>
      _errors.entries.where((entry) => entry.value != null).isNotEmpty;

  /// {@template formkit.formKit.errors}
  /// The fields errors
  /// {@endtemplate}
  Map<String, String?> get errors => {..._errors};

  /// {@template formkit.formKit.enqueueValidation}
  /// Enqueue the validation for all registered fields
  /// respecting [ValidatorTimerMode] on each field
  /// {@endtemplate}
  void enqueueValidation() {
    for (final field in _fields) {
      field.enqueueValidation(_values[field.name]);
    }
  }

  /// {@template formkit.formKit.validate}
  /// Runs all validations in the fields
  ///
  /// It returns the validation result,
  /// if the value is [null] it indicates the field is valid
  /// {@endtemplate}
  Future<Map<String, String?>> validate() async {
    _errors.clear();
    _errors.addAll(await _validateFields(_fields));

    _forceUpdate();

    return _errors;
  }

  @internal
  void register(FormKitFieldState field) {
    _fields.add(field);

    if (widget.initialValues != null && _values.containsKey(field.name)) {
      field.setValue(_values[field.name]);
    }
  }

  @internal
  void setFieldDependencies(FormKitFieldState field, Set<String> dependencies) {
    _fieldDependencies[field] = dependencies;
  }

  @internal
  void unregister(FormKitFieldState field) {
    _fields.remove(field);
    _dirtyFields.remove(field);
    _fieldDependencies.remove(field);
  }

  @internal
  void onFieldChanged(FormKitFieldState field, dynamic value) {
    _values[field.name] = value;
    _dirtyFields.add(field);

    if (widget.autovalidateMode == AutovalidateMode.onUserInteraction) {
      _validateDependentFields(field.name);
    }
  }

  @internal
  void onFieldValidated(String name, String? error) => _errors[name] = error;

  Future<Map<String, String?>> _validateFields(
      Set<FormKitFieldState> fields) async {
    final errors = Map<String, String?>();

    for (final field in fields) {
      final name = field.name;
      errors[name] = await field.validate(_values[name], _values);
    }

    return errors;
  }

  void _validateDependentFields(String name) {
    _fieldDependencies.entries
        // Get all the fields that depends on the field
        .where((entry) => entry.value.contains(name))
        // Map to the [FormKitFieldState] instance
        .map((entry) => entry.key)
        // Enqueue the validation on each field
        .forEach((field) => field.enqueueValidation(_values[field.name]));
  }

  void _updateFromInitialValues(FormKit oldWidget) {
    if (mapEquals(oldWidget.initialValues, widget.initialValues)) {
      return;
    }

    final newValues = widget.initialValues ?? {};
    final unmodifiedFields =
        _fields.where((field) => !_dirtyFields.contains(field));

    for (final field in unmodifiedFields) {
      _values[field.name] = newValues[field.name];
      field.setValue(_values[field.name]);
    }
  }

  void _forceUpdate() {
    setState(() {
      _generation++;
    });
  }
}

class _FormKitScope extends InheritedWidget {
  _FormKitScope({
    Key? key,
    required Widget child,
    required FormKitState formState,
    required int generation,
  })   : _formState = formState,
        _generation = generation,
        super(key: key, child: child);

  final FormKitState _formState;
  final int _generation;

  /// {@macro formkit.formKit.submit}
  Future<Map<String, dynamic?>?> submit() => _formState.submit();

  /// {@macro formkit.formKit.values}
  Map<String, dynamic> get values => _formState.values;

  /// {@macro formkit.formKit.setValues}
  void setValues(Map<String, dynamic> values) => _formState.setValues(values);

  /// {@macro formkit.formKit.validate}
  Future<Map<String, String?>> validate() => _formState.validate();

  /// {@macro formkit.formKit.enqueueValidation}
  void enqueueValidation() => _formState.enqueueValidation();

  /// {@macro formkit.formKit.errors}
  Map<String, String?> get errors => _formState.errors;

  /// {@macro formkit.formKit.hasErrors}
  bool get hasErrors => _formState.hasErrors;

  @internal
  FormKit get form => _formState.widget;

  @override
  bool updateShouldNotify(_FormKitScope old) => _generation != old._generation;
}
