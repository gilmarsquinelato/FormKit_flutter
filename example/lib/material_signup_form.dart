import 'package:flutter/material.dart';
import 'package:formkit/formkit.dart';

class SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormKit(
            onSubmit: _signup,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validatorTimerMode: ValidatorTimerMode.debounce,
            child: Column(
              children: [
                FormKitTextField(
                  name: 'name',
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: FormKitRequiredValidator(
                    constantErrorMessage('Name is required'),
                  ),
                ),
                FormKitTextField(
                  name: 'email',
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: FormKitValidatorComposer([
                    FormKitRequiredValidator(
                      constantErrorMessage('Email is required'),
                    ),
                    FormKitEmailValidator(
                      constantErrorMessage('Invalid email'),
                    ),
                  ]),
                ),
                FormKitDateField(
                  name: 'birthDate',
                  decoration: const InputDecoration(
                    labelText: 'Birth date',
                  ),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  validator: FormKitRequiredValidator(
                    constantErrorMessage('Birth date is required'),
                  ),
                ),
                FormKitTextField(
                  name: 'password',
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validatorInterval: const Duration(milliseconds: 100),
                  validator: FormKitValidatorComposer([
                    FormKitRequiredValidator(
                      constantErrorMessage('Password is required'),
                    ),
                    FormKitMinLengthValidator(
                      8,
                      constantErrorMessage(
                          'Password must have at least 8 characters'),
                    ),
                  ]),
                ),
                FormKitTextField(
                  name: 'repeatPassword',
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Repeat Password',
                  ),
                  obscureText: true,
                  validatorInterval: const Duration(milliseconds: 100),
                  validator: FormKitEqualFieldValidator(
                    'password',
                    constantErrorMessage('The password don\'t match'),
                  ),
                ),
                FormKitCheckboxField(
                  name: 'terms',
                  title: const Text('I read and agree with the terms'),
                  validator: FormKitRequiredValidator(
                    constantErrorMessage('You must agree with the terms'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormKitSubmitBuilder(
                    builder: (_, submit) => ElevatedButton(
                      child: const Text('Signup'),
                      onPressed: submit,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signup(Map<String, dynamic?> values) {
    print('Signup successful: $values');
  }
}
