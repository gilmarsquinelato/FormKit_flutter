import 'package:formkit/src/validators/formkit_validator.dart';

/// A maximum length validator.
/// This validator only works with [String] based fields.
///
/// This validator checks if the field value has at maximum [maxLength] characters.
///
/// {@tool snippet}
/// ```dart
/// FormKitMaxLengthValidator(
///   8,
///   constantErrorMessage('This field must have at maximum 8 characters'),
/// )
/// ```
/// {@end-tool}
class FormKitMaxLengthValidator extends FormKitValidator<String> {
  final ErrorMessageBuilder<String> errorMessageBuilder;
  final int maxLength;

  FormKitMaxLengthValidator(this.maxLength, this.errorMessageBuilder);

  @override
  Future<String> validate(String value, Map<String, dynamic> formValues) async {
    if (value.length > maxLength) {
      return errorMessageBuilder(value, formValues);
    }

    return null;
  }
}
