import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_auth.dart';
import '../validation.dart';
import 'home_page.dart';
import 'register_page.dart';
class LoginScreen extends StatelessWidget {
  var username = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}
class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}  

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;
  User? user;
  FieAuth fieAuth = FieAuth();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  var password = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Email Address',
          ),
          controller: _emailTextController,
          validator: (value) => validation.validateEmail(email: value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          obscureText: true,
          controller: _passwordTextController,
          validator: (value) => validation.validatePassword(value: value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        ElevatedButton(
          onPressed: () async {
            user = await fieAuth.signIn(
                _emailTextController.text, _passwordTextController.text);
            if (user != null) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(user: user)));
            }
          },
          child: const Text('Login'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => createAccount()));
          },
          child: const Text('Create Account'),
        ),
      ],
    );
  }
}