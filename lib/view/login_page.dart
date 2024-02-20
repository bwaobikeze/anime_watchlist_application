import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_auth.dart';
import '../validation.dart';
import 'home_page.dart';
import 'register_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';

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

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final db = FirebaseFirestore.instance;

  User? user;

  FieAuth fieAuth = FieAuth();

  final _emailTextController = TextEditingController();

  final _passwordTextController = TextEditingController();

  var password = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is Authenticated) {
          // Navigate to the authenticated screen
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else if (state is Unauthenticated) {
          // Show an error message
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login Failed')));
        }
      },
      builder: (context, state) {
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
              onPressed: () {
                Text("out of the if statement");
                if (_formKey.currentState!.validate()) {
                  Text("inside the if statement");
                  context.read<AuthBloc>().add(LoginEvent(
                      email: _emailTextController.text,
                      password: _passwordTextController.text));
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
      },
    );
  }
}
