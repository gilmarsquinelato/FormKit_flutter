import 'package:formkit/src/validators/formkit_validator.dart';

/// A maximum value validator.
/// This validator only works with [num] based fields.
///
/// This validator checks if the field value is bigger than [max].
///
/// {@tool snippet}
/// ```dart
/// FormKitMaxValidator(
///   8,
///   constantErrorMessage('The value must not be bigger than 8'),
/// )
/// ```
/// {@end-tool}
class FormKitMaxValidator<T extends num> extends FormKitValidator<T> {
  final ErrorMessageBuilder<T> errorMessageBuilder;
  final T max;

  FormKitMaxValidator(this.max, this.errorMessageBuilder);

  @override
  Future<String?> validate(T? value, Map<String, dynamic> formValues) async {
    if (value != null && value > max) {
      return errorMessageBuilder(value, formValues);
    }

    return null;
  }
}
