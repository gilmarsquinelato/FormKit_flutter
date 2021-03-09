import 'package:flutter/widgets.dart';
import 'package:formkit/formkit.dart';

/// A widget that provides a convenient way to submit the form.
///
///
/// {@tool snippet}
/// ```dart
/// FormKitSubmitBuilder(
///   builder: (context, submit) => ElevatedButton(
///     child: Text('Save'),
///     onPressed: submit,
///   ),
/// )
/// ```
/// {@end-tool}
class FormKitSubmitBuilder extends StatelessWidget {
  const FormKitSubmitBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final SubmitBuilder builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, () => FormKit.of(context).submit());
  }
}

typedef SubmitBuilder = Widget Function(
  BuildContext context,
  VoidCallback submit,
);
