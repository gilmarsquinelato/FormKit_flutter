import 'package:flutter/cupertino.dart';
import 'package:formkit/cupertino.dart';
import 'package:formkit/formkit.dart';

class CupertinoLoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Login'),
        previousPageTitle: 'Example',
      ),
      child: SafeArea(
        bottom: false,
        child: FormKit(
          onSubmit: _onSubmit,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: FormKitCupertinoTextField(
                  name: 'email',
                  placeholder: 'Email',
                  clearButtonMode: OverlayVisibilityMode.editing,
                  textInputAction: TextInputAction.next,
                  validator: FormKitValidatorComposer([
                    FormKitRequiredValidator(
                      constantErrorMessage('Email is required'),
                    ),
                    FormKitEmailValidator(
                      constantErrorMessage('Invalid email'),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: FormKitCupertinoTextField(
                  name: 'password',
                  placeholder: 'Password',
                  clearButtonMode: OverlayVisibilityMode.editing,
                  textInputAction: TextInputAction.send,
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
              ),
              FormKitCupertinoSwitchField(
                name: 'remember',
                prefix: SizedBox(width: 120, child: Text('Remember me')),
              ),
              Padding(
                  padding: const EdgeInsets.all(3.0),
                child: FormKitSubmitBuilder(
                  builder: (context, submit) => CupertinoButton.filled(
                    child: Text('Login'),
                    onPressed: submit,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit(Map<String, dynamic> values, _errors) {
    print('Login with: $values');
  }
}
