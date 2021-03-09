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
                  decoration: InputDecoration(
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
                  decoration: InputDecoration(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormKitSubmitBuilder(
                    builder: (_, submit) => ElevatedButton(
                      child: Text('Login'),
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
    final loginData = Login.fromJson(values);
    print('Login successful: $loginData');
  }
}

class Login {
  final String email;
  final String password;

  Login({required this.email, required this.password});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      email: json['email'],
      password: json['password'],
    );
  }

  @override
  String toString() {
    return 'Login(email: $email, password: $password)';
  }
}
