import 'package:formkit/src/validators/formkit_validator.dart';

/// A field equility validator.
///
/// This validator compares the value of the current field
/// with another field's value based on the given [otherFieldName] parameter.
///
/// {@tool snippet}
/// Given that we have two fields, `password` and `repeatPassword`
/// and we want that `repeatPassword` must be equal to `password`.
///
/// In the `repeatPassword` field widget we just have
/// to define the following validator.
///
/// ```dart
/// FormKitEqualFieldValidator<String>(
///   'password',
///   constantErrorMessage('The passwords don\'t match'),
/// )
/// ```
/// {@end-tool}
class FormKitEqualFieldValidator<T> extends FormKitValidator<T> {
  final ErrorMessageBuilder<T> errorMessageBuilder;
  final String otherFieldName;

  FormKitEqualFieldValidator(this.otherFieldName, this.errorMessageBuilder) {
    fieldDependencies.add(otherFieldName);
  }

  @override
  Future<String?> validate(T? value, Map<String, dynamic> formValues) async {
    if (value != formValues[otherFieldName]) {
      return errorMessageBuilder(value, formValues);
    }

    return null;
  }
}
