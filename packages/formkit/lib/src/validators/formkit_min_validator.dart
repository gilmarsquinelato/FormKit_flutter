import 'package:formkit/src/validators/formkit_validator.dart';

/// A minimum value validator.
/// This validator only works with [num] based fields.
///
/// This validator checks if the field value is lower than [min].
///
/// {@tool snippet}
/// ```dart
/// FormKitMinValidator(
///   3,
///   constantErrorMessage('The value must not be lower than 3'),
/// )
/// ```
/// {@end-tool}
class FormKitMinValidator extends FormKitValidator<num> {
  final ErrorMessageBuilder<num> errorMessageBuilder;
  final num min;

  FormKitMinValidator(this.min, this.errorMessageBuilder);

  @override
  Future<String?> validate(num? value, Map<String, dynamic> formValues) async {
    if (value != null && value < min) {
      return errorMessageBuilder(value, formValues);
    }

    return null;
  }
}
