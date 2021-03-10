import 'package:formkit/src/validators/formkit_validator.dart';

/// Required validator.
///
/// A validator that will check if the given value is null
/// and in case of it's a [String] it will check if this value is empty.
///
///
/// {@tool snippet}
///
/// The simplest way to define it is.
///
/// ```dart
/// FormKitRequiredValidator(
///   constantErrorMessage('This field is required'),
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
///
/// For dynamic messages based on the current field value or form values.
///
/// ```dart
/// FormKitRequiredValidator(
///   (String value, Map<String, dynamic> formValues) =>
///     'The value $value is invalid',
/// )
/// ```
/// {@end-tool}
class FormKitRequiredValidator<T> extends FormKitValidator<T> {
  final ErrorMessageBuilder<T> errorMessageBuilder;

  FormKitRequiredValidator(this.errorMessageBuilder);

  @override
  Future<String?> validate(T? value, Map<String, dynamic> formValues) async {
    if (value == null) {
      return errorMessageBuilder(value, formValues);
    }

    if (value is String && value.isEmpty) {
      return errorMessageBuilder(value, formValues);
    }

    if (value is bool && !value) {
      return errorMessageBuilder(value, formValues);
    }

    return null;
  }
}
