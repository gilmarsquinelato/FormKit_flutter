import 'package:example/login_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormKit Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExamplesCatalog(),
    );
  }
}

class ExamplesCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormKit Demo'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Select one of the examples below'),
          ),
          ListTile(
            title: const Text('Basic form (Login Form)'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => LoginForm(),
            )),
          ),
        ],
      ),
    );
  }
}
