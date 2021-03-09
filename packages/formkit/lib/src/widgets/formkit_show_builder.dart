import 'package:flutter/widgets.dart';
import 'package:formkit/formkit.dart';

/// This widget will show its child only if
/// the given field has the expected given value
class FormKitShowBuilder<T> extends StatelessWidget {
  const FormKitShowBuilder({
    Key? key,
    required this.fieldName,
    required this.expectedValue,
    required this.builder,
  }) : super(key: key);

  final String fieldName;
  final T expectedValue;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final form = FormKit.of(context);
    final fieldValue = form.values[fieldName];

    if (expectedValue != fieldValue) {
      return SizedBox.shrink();
    }

    return builder(context);
  }
}
