import 'package:formkit/src/validators/formkit_validator.dart';

/// A minimum length validator.
/// This validator only works with [String] based fields.
///
/// This validator checks if the field value has at least [minLength] characters.
///
/// {@tool snippet}
/// ```dart
/// FormKitMinLengthValidator(
///   3,
///   constantErrorMessage('This field must have at least 3 characters'),
/// )
/// ```
/// {@end-tool}
class FormKitMinLengthValidator extends FormKitValidator<String> {
  final ErrorMessageBuilder<String> errorMessageBuilder;
  final int minLength;

  FormKitMinLengthValidator(this.minLength, this.errorMessageBuilder);

  @override
  Future<String?> validate(String? value, Map<String, dynamic> formValues) async {
    if (value != null && value.length < minLength) {
      return errorMessageBuilder(value, formValues);
    }

    return null;
  }
}
