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
class FormKitMinValidator<T extends num> extends FormKitValidator<T> {
  final ErrorMessageBuilder<T> errorMessageBuilder;
  final T min;

  FormKitMinValidator(this.min, this.errorMessageBuilder);

  @override
  Future<String?> validate(T? value, Map<String, dynamic> formValues) async {
    if (value != null && value < min) {
      return errorMessageBuilder(value, formValues);
    }

    return null;
  }
}
