import 'package:flutter/material.dart';
import 'package:formkit/formkit.dart';

class MaterialFields extends StatelessWidget {
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
            onSubmit: _onSubmit,
            child: Column(
              children: [
                FormKitTextField(
                  name: 'textField',
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Text Field',
                  ),
                ),
                FormKitDateField(
                  name: 'dateField',
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  decoration: const InputDecoration(
                    labelText: 'Date Field',
                  ),
                ),
                FormKitTimeField(
                  name: 'timeField',
                  decoration: const InputDecoration(
                    labelText: 'Time Field',
                  ),
                ),
                FormKitDateRangeField(
                  name: 'dateRangeField',
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  decoration: const InputDecoration(
                    labelText: 'Date Range Field',
                  ),
                ),
                FormKitDropdownField(
                  name: 'dropdownField',
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Dropdown Field',
                  ),
                  items: [
                    DropdownMenuItem<String>(
                        value: 'option1', child: Text('Option 1')),
                    DropdownMenuItem<String>(
                        value: 'option2', child: Text('Option 2')),
                    DropdownMenuItem<String>(
                        value: 'option3', child: Text('Option 3')),
                  ],
                ),
                FormKitRadioField(
                  name: 'radioField',
                  decoration: const InputDecoration(
                    labelText: 'Radio Field',
                  ),
                  options: {
                    'opt1': Text('Opt 1'),
                    'opt2': Text('Opt 2'),
                    'opt3': Text('Opt 3'),
                  },
                ),
                FormKitCheckboxField(
                  name: 'checkboxField',
                  title: Text('Checkbox Field'),
                ),
                FormKitSwitchField(
                  name: 'switchField',
                  title: Text('Switch Field'),
                ),
                FormKitSliderField(
                  name: 'sliderField',
                  decoration: const InputDecoration(
                    labelText: 'Slider Field',
                  ),
                ),
                FormKitRangeSliderField(
                  name: 'rangeSliderField',
                  decoration: const InputDecoration(
                    labelText: 'Range Slider Field',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormKitSubmitBuilder(
                    builder: (_, submit) => ElevatedButton(
                      child: const Text('Submit'),
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

  void _onSubmit(Map<String, dynamic> values) {
    print('Form submitted with the following values: $values');
  }
}
