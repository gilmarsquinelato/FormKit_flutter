import 'package:formkit/src/validators/formkit_validator.dart';

/// A [RegExp] validator.
/// This validator only works with [String] based fields.
///
/// This validator checks if the field value matches the given [pattern].
///
/// {@tool snippet}
/// ```dart
/// FormKitMatchValidator(
///   RegExp(r'^[a-zA-Z0-9]+$'), // alphanumeric pattern
///   constantErrorMessage('This field must have only letters and numbers'),
/// )
/// ```
/// {@end-tool}
class FormKitMatchValidator extends FormKitValidator<String> {
  final ErrorMessageBuilder<String> errorMessageBuilder;
  final RegExp pattern;

  FormKitMatchValidator(this.pattern, this.errorMessageBuilder);

  @override
  Future<String> validate(String value, Map<String, dynamic> formValues) async {
    if (!pattern.hasMatch(value)) {
      return errorMessageBuilder(value, formValues);
    }

    return null;
  }
}
