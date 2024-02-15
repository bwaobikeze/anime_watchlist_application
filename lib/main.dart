import 'package:anime_watchlist_app/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'firebase_auth.dart';

//Main function to run the app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AnimeWatchlistApp());
}

//Main class for the app
class AnimeWatchlistApp extends StatelessWidget {
  const AnimeWatchlistApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Watchlist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

//Login screen
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

//Login form
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
          // onChanged: (text) {
          //   print('First text field: $text');
          //   username = text;

          // },
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
            // if (_formKey.currentState!.validate()) {

            // }
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

//Create account screen
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

//Create account form
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

//Home screen
class HomeScreen extends StatelessWidget {
  String _user = FirebaseAuth.instance.currentUser!.uid;
  HomeScreen({Key? key, User? user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: ElevatedButton(
          onPressed: () {
            FieAuth fieAuth = FieAuth();
            fieAuth.signout();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: const Text('Logout'),
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          const Text('Welcome to the Anime Watchlist App'),
          Text(_user)
        ]),
      ),
    );
  }
}
