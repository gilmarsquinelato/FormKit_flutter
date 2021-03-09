import 'package:formkit/formkit.dart';
import 'package:formkit/src/validators/formkit_validator_composer.dart';

/// The validator base class.
///
/// It allows us to do async validations
/// and field dependent validations
/// i.e. a field must be equal to another one.
///
/// See also
///
///  * [FormKitRequiredValidator], [FormKitValidatorComposer]
abstract class FormKitValidator<T> {
  /// Indicates the fields this validator will depends on.
  ///
  /// [FormKit] will identify what fields must be re-validated
  /// when another one is changed based on this field;
  final Set<String> fieldDependencies = Set();

  /// The validation process.
  Future<String?> validate(T? value, Map<String, dynamic> formValues);
}

typedef ErrorMessageBuilder<T> = String Function(
    T? value, Map<String, dynamic> formValues);

/// A helper function to reduce the verbosity of creating an error message for the validators.
ErrorMessageBuilder<T?> constantErrorMessage<T>(String errorMessage) =>
    (T? value, Map<String, dynamic> formValues) => errorMessage;
