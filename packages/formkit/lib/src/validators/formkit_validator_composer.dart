import 'package:formkit/src/validators/formkit_validator.dart';

/// A validator composer
///
/// It consists of receiving a list of validators
/// and iterate over each one of them
/// returning the first error found or null if no error messages given
///
/// {@tool snippet}
/// TODO: implement example
/// {@end-tool}
class FormKitValidatorComposer<T> extends FormKitValidator<T> {
  final List<FormKitValidator<T>> validators;

  FormKitValidatorComposer(this.validators) {
    for (final validator in validators) {
      fieldDependencies.addAll(validator.fieldDependencies);
    }
  }

  @override
  Future<String> validate(T value, Map<String, dynamic> formValues) async {
    for (final validator in validators) {
      final error = await validator.validate(value, formValues);
      if (error != null) {
        return error;
      }
    }

    return null;
  }
}
