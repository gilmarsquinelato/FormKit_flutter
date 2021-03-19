import 'package:flutter/cupertino.dart';
import 'package:formkit/cupertino.dart';
import 'package:formkit/formkit.dart';

class CupertinoLoginFormSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Login - Form Section'),
        previousPageTitle: 'Example',
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: FormKit(
            onSubmit: _onSubmit,
            child: CupertinoFormSection(
              header: Text('Login Form'),
              children: [
                FormKitCupertinoTextField.formRow(
                  name: 'email',
                  placeholder: 'required',
                  prefix: SizedBox(width: 120, child: Text('Email')),
                  clearButtonMode: OverlayVisibilityMode.editing,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormKitValidatorComposer([
                    FormKitRequiredValidator(
                      constantErrorMessage('Email is required'),
                    ),
                    FormKitEmailValidator(
                      constantErrorMessage('Invalid email'),
                    ),
                  ]),
                ),
                FormKitCupertinoTextField.formRow(
                  name: 'password',
                  placeholder: 'required',
                  prefix: SizedBox(width: 120, child: Text('Password')),
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
                FormKitCupertinoSwitchField(
                  name: 'remember',
                  prefix: SizedBox(width: 120, child: Text('Remember me')),
                ),
                CupertinoFormRow(
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
      ),
    );
  }

  _onSubmit(Map<String, dynamic?> values, _errors) {
    print('Login with: $values');
  }
}
