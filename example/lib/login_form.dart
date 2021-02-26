import 'package:flutter/material.dart';
import 'package:formkit/formkit.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormKitState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormKitState>();
  }

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
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validatorTimerMode: ValidatorTimerMode.debounce,
            // default value
            // validatorInterval: const Duration(milliseconds: 250),
            child: Column(
              children: [
                FormKitTextField(
                  name: 'email',
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: FormKitEmailValidator(
                    constantErrorMessage('Invalid email'),
                  ),
                ),
                FormKitTextField(
                  name: 'password',
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validatorInterval: const Duration(milliseconds: 100),
                  validator: FormKitMinLengthValidator(
                    8,
                    constantErrorMessage('Password must have at least 8 characters'),
                  ),
                ),
                ElevatedButton(
                  child: Text('Login'),
                  onPressed: _login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    print('starting the login process');
    final form = formKey.currentState;
    final result = await form.validate();

    print('Validation result: $result');

    if (form.hasErrors) {
      print('Validation failed');
      return;
    }

    final loginData = Login.fromJson(form.values);
    print('Login successful: $loginData');
  }
}

class Login {
  final String email;
  final String password;

  Login({this.email, this.password});

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
