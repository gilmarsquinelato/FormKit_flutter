import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formkit/cupertino.dart';
import 'package:formkit/formkit.dart';

class CupertinoFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Fields'),
        previousPageTitle: 'Example',
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: FormKit(
            onSubmit: _onSubmit,
            child: CupertinoFormSection(
              header: Text('Section'),
              children: [
                FormKitCupertinoTextField.formRow(
                  name: 'textField',
                  placeholder: 'placeholder',
                  prefix: SizedBox(width: 120, child: Text('Text Field')),
                  clearButtonMode: OverlayVisibilityMode.editing,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                ),
                FormKitCupertinoSwitchField(
                  name: 'switchField',
                  prefix: SizedBox(width: 120, child: Text('Switch Field')),
                ),
                FormKitCupertinoDatePickerField(
                  name: 'dateTimeField',
                  dateFormatter: MaterialLocalizations.of(context).formatShortDate,
                  timeFormatter: MaterialLocalizations.of(context).formatTimeOfDay,
                  prefix: SizedBox(width: 120, child: Text('DateTime Field')),
                  placeholder: 'select a date',
                ),
                FormKitCupertinoDatePickerField(
                  name: 'dateField',
                  mode: CupertinoDatePickerMode.date,
                  dateFormatter: MaterialLocalizations.of(context).formatShortDate,
                  prefix: SizedBox(width: 120, child: Text('Date Field')),
                ),
                FormKitCupertinoDatePickerField(
                  name: 'timeField',
                  mode: CupertinoDatePickerMode.time,
                  timeFormatter: MaterialLocalizations.of(context).formatTimeOfDay,
                  prefix: SizedBox(width: 120, child: Text('Time Field')),
                ),
                CupertinoFormRow(
                  child: FormKitSubmitBuilder(
                    builder: (context, submit) => CupertinoButton.filled(
                      child: Text('Submit'),
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
    print('Submitted with: $values');
  }
}
