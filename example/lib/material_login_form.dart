import 'package:flutter/material.dart';
import 'package:formkit/formkit.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormKit(
            onSubmit: _login,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validatorTimerMode: ValidatorTimerMode.debounce,
            child: Column(
              children: [
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
                FormKitCheckboxField(
                  name: 'remember',
                  title: const Text('Remember me'),
                  horizontalTitleGap: 0,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormKitSubmitBuilder(
                    builder: (_, submit) => ElevatedButton(
                      child: const Text('Login'),
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

  void _login(Map<String, dynamic?> values) {
    print('Login successful: $values');
  }
}
