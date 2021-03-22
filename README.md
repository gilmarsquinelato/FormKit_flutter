# FormKit

Flutter forms made easy.

---
## **🚧 WARNING**

This library is not stable yet!

---

## Examples

* Material Login Form [link](./example/lib/material_login_form.dart)
* Material SignUp Form [link](./example/lib/material_signup_form.dart)
* All Material Fields  [link](./example/lib/material_fields.dart)

## Features

### Validators

- [x] Async validators
- [x] Backpressure validation (throttling, debounce or none)
- - [x] Custom timer duration
- - [x] When defined in FormKit widget will serve as default for children fields
- [x] Custom validators
- - [x] User custom validator
- - [x] Validator composer
- - [x] Required field
- - [x] Equal to another field
- - [x] Equal to value
- - [x] Minimum length
- - [x] Maximum length
- - [x] Minimum value
- - [x] Maximum value
- - [x] RegExp
- - [x] Email

### Form fields

- [x] Custom user defined field
- [x] Material Fields
- - [x] Text Field
- - [x] Checkbox Field
- - [x] Switch Field
- - [x] Date Field
- - [x] Date range Field
- - [x] Time Field
- - [x] Radio Field
- - [x] Slider Field
- - [x] Range Slider Field
- - [x] Dropdown Field
- [ ] Cupertino Fields
- - [x] Text Field
- - [x] Switch Field
- - [x] Date Picker Field
- - [ ] Timer Picker Field
- - [ ] Picker Field
- - [ ] Slider Field
- - [ ] Segmented Control Field
- - [ ] Sliding Segmented Control Field

### Form

- [x] All public interface accessible via context or key
- [x] Context based access: ```FormKit.of(context)```
- [x] Key based access
- [x] Enable/Disable all children fields
- [x] Initial fields values: `initialValues: {}` -- (`Map<String, dynamic?>()`)
- [x] Dynamically set the fields value: `FormKit.of(context).setValues({})` or `formKey.currentState.setValues({})`
- [x] Trigger validation
- [x] Trigger validation respecting backpressure
- [x] Retrieve form errors
- [x] Retrieve form values
- [x] onSubmit callback
- [x] FormKitSubmitBuilder
- [x] FormKitShowBuilder

### To do:

- [ ] Complete example app
- [ ] Unit tests
- [ ] Implement all Material fields
- [ ] Implement all Cupertino fields
- [ ] Docs
- [ ] CI
- [ ] Publish
