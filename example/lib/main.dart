import 'package:example/material_fields.dart';
import 'package:example/material_login_form.dart';
import 'package:example/material_signup_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
            title: const Text('Login Form'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => LoginForm(),
            )),
          ),
          ListTile(
            title: const Text('Signup Form'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => SignupForm(),
            )),
          ),
          ListTile(
            title: const Text('All Fields'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => MaterialFields(),
            )),
          ),
        ],
      ),
    );
  }
}
