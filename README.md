# FormKit

Flutter forms made easy.

---
## **🚧 WARNING**

This library is not stable yet!

---

## Features

### Validators

- [x] Async validators
- [x] Backpressure validation (throttling, debounce or none)
- - [x] Custom timer duration
- - [x] Defined in [FormKit](./packages/formkit/lib/src/formkit.dart) Widget to serve as default for children fields
- [x] Custom validators
- - [x] User custom validator
- - [x] Validator composer: [code](./packages/formkit/lib/src/validators/formkit_validator_composer.dart)
- - [x] Required field: [code](./packages/formkit/lib/src/validators/formkit_required_validator.dart)
- - [x] Equal to another field: [code](./packages/formkit/lib/src/validators/formkit_equal_field_validator.dart)
- - [x] Equal to value: [code](./packages/formkit/lib/src/validators/formkit_equal_validator.dart)
- - [x] Minimum length: [code](./packages/formkit/lib/src/validators/formkit_min_length_validator.dart)
- - [x] Maximum length: [code](./packages/formkit/lib/src/validators/formkit_max_length_validator.dart)
- - [x] Minimum value: [code](./packages/formkit/lib/src/validators/formkit_min_validator.dart)
- - [x] Maximum value: [code](./packages/formkit/lib/src/validators/formkit_max_validator.dart)
- - [x] RegExp: [code](./packages/formkit/lib/src/validators/formkit_match_validator.dart)
- - [x] Email: [code](./packages/formkit/lib/src/validators/formkit_email_validator.dart)

### Form fields

- [x] Custom user defined field: [code](./packages/formkit/lib/src/fields/formkit_field.dart)
- [x] Text Field: [code](./packages/formkit/lib/src/fields/formkit_text_field.dart)
- - [x] Supports all Material TextField widget properties
- [ ] Checkbox Field
- [ ] Date Field
- [ ] Time Field
- [ ] DateTime Field
- [ ] Radio Field
- [ ] Slider Field
- [ ] Switch Field

### Form

- [x] All public interface accessible via context or key
- [x] Context based access: ```FormKit.of(context)```
- [x] Key based access
- [x] Initial fields values: `initialValues: {}` -- (`Map<String, dynamic?>()`)
- [x] Dynamically set the fields value: `FormKit.of(context).setValues({})` or `formKey.currentState.setValues({})`
- [x] Trigger validation
- [x] Trigger validation respecting backpressure
- [x] Retrieve form errors
- [x] Retrieve form values
- [x] onSubmit callback
- [x] FormKitSubmitBuilder: [code](./packages/formkit/lib/src/widgets/formkit_submit_builder.dart)
- [ ] Jump to next field on press enter or tab
- [x] FormKitShowBuilder: [code](./packages/formkit/lib/src/widgets/formkit_show_builder.dart)

### To do:

- [ ] Complete example app
- [ ] Unit tests
- [ ] Implement all Material fields
- [ ] Implement all Cupertino fields
- [ ] Docs
- [ ] CI
- [ ] Publish
