import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_auth.dart';
import '../validation.dart';
import 'home_page.dart';
import 'login_page.dart';
class createAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: createAccountForm(),
        ),
      ),
    );
  }
}


class createAccountForm extends StatefulWidget {
  createAccountForm({Key? key}) : super(key: key);

  @override
  State<createAccountForm> createState() => _createAccountFormState();
}

class _createAccountFormState extends State<createAccountForm> {
  final db = FirebaseFirestore.instance;
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _usernameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  User? user;
  FieAuth fieAuth = FieAuth();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'First Name',
          ),
          controller: _nameTextController,
          validator: (value) => validation.nameValidator(name: value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Last Name',
          ),
          controller: _lastNameTextController,
          validator: (value) => validation.lastNameValidator(lastName: value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Username',
          ),
          controller: _usernameTextController,
          validator: (value) => validation.usernameValidator(username: value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Email Address',
          ),
          controller: _emailTextController,
          validator: (value) => validation.validateEmail(email: value),
          autovalidateMode: AutovalidateMode.onUserInteraction
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          controller: _passwordTextController,
          validator: (value) => validation.validatePassword(value: value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        ElevatedButton(
          onPressed: () async {
            print('Create Account button pressed');
            user = await fieAuth.signUp(
                _emailTextController.text, _passwordTextController.text);
            if (user != null) {
              final _userProfile = {
                'Name': _nameTextController.text,
                'LastName': _lastNameTextController.text,
                'username': _usernameTextController.text,
                'Email': _emailTextController.text,
                'Password': _passwordTextController.text,
                'userID': user!.uid
              };
              try {
                db.collection('users').add(_userProfile);
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              } catch (e) {
                print(e);
              }
            }
          },
          child: const Text('Create Account'),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const Text('Back to Login')),
      ],
    );
  }
}