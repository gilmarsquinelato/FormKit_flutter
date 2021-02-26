import 'package:formkit/src/validators/formkit_validator.dart';

/// A value equility validator.
///
/// This validator compares the value of the current field
/// with the given [expectedValue] parameter.
///
/// {@tool snippet}
/// ```dart
/// FormKitEqualValidator(
///   'search',
///   constantErrorMessage('It must be equal to "search"'),
/// )
/// ```
/// {@end-tool}
class FormKitEqualValidator<T> extends FormKitValidator<T> {
  final ErrorMessageBuilder<T> errorMessageBuilder;
  final T expectedValue;

  FormKitEqualValidator(this.expectedValue, this.errorMessageBuilder);

  @override
  Future<String> validate(T value, Map<String, dynamic> formValues) async {
    if (value != expectedValue) {
      return errorMessageBuilder(value, formValues);
    }

    return null;
  }
}
