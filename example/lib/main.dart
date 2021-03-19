import 'package:example/cupertino_fields.dart';
import 'package:example/cupertino_login_form.dart';
import 'package:example/cupertino_login_form_section.dart';
import 'package:example/material_fields.dart';
import 'package:example/material_login_form.dart';
import 'package:example/material_signup_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'FormKit Example',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.light),
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      home: ExamplesCatalog(),
    );
  }
}

class ExamplesCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormKit Example'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Material',
              style: Theme.of(context).textTheme.headline5,
            ),
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
          ListTile(
            title: Text(
              'Cupertino',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          ListTile(
            title: const Text('Login Form'),
            onTap: () => Navigator.of(context).push(CupertinoPageRoute(
              builder: (_) => CupertinoLoginForm(),
            )),
          ),
          ListTile(
            title: const Text('Login Form - Form Section'),
            onTap: () => Navigator.of(context).push(CupertinoPageRoute(
              builder: (_) => CupertinoLoginFormSection(),
            )),
          ),
          ListTile(
            title: const Text('All Fields'),
            onTap: () => Navigator.of(context).push(CupertinoPageRoute(
              builder: (_) => CupertinoFields(),
            )),
          ),
        ],
      ),
    );
  }
}
