import 'package:formkit/src/validators/formkit_match_validator.dart';
import 'package:formkit/src/validators/formkit_validator.dart';

/// A [RegExp] validator.
/// This validator only works with [String] based fields.
///
/// This validator checks if the field value matches the given [pattern].
///
/// {@tool snippet}
/// ```dart
/// FormKitEmailValidator(
///   constantErrorMessage('This email is invalid'),
/// )
/// ```
/// {@end-tool}
class FormKitEmailValidator extends FormKitMatchValidator {
  FormKitEmailValidator(ErrorMessageBuilder<String> errorMessageBuilder)
      : super(_emailRegex, errorMessageBuilder);
}

/// Email regular expression based on the HTML5 spec
/// https://html.spec.whatwg.org/multipage/input.html#e-mail-state-%28type=email%29
final _emailRegex = RegExp(
  r'''^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$''',
);
