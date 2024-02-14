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
          padding: EdgeInsets.all(16.0),
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
  final db = FirebaseFirestore.instance;
  User? user;
  FieAuth fieAuth = FieAuth();
  var username = '';
  var password = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Username',
          ),
          onChanged: (text) {
            print('First text field: $text');
            username = text;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          onChanged: (text) {
            print('Second text field: $text');
            password = text;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters long';
            }
            return null;
          
          },
        ),
        ElevatedButton(
          onPressed: () async {
            print('Login button pressed');
            user = await fieAuth.signIn(username, password);
            if (user != null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => homeScreen()));
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
  User? user;
  FieAuth fieAuth = FieAuth();
  var name = '';
  var lastName = '';
  var username = '';
  var email = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'First Name',
          ),
          onChanged: (text) {
            // print('First Name : $text');
            name = text;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Last Name',
          ),
          onChanged: (text) {
            // print('Last Name : $text');
            lastName = text;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Username',
          ),
          onChanged: (text) {
            // print('Username: $text');
            username = text;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Email Address',
          ),
          onChanged: (text) {
            // print('Email: $text');
            email = text;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          onChanged: (text) {
            // print('Password: $text');
            password = text;
          },
        ),
        ElevatedButton(
          onPressed: () async {
            print('Create Account button pressed');
            user = await fieAuth.signUp(email, password);
            if (user != null) {
              final _userProfile = {
                'Name': name,
                'LastName': lastName,
                'username': username,
                'Email': email,
                'Password': password,
                'userID': user!.uid
              };
              db.collection('users').add(_userProfile);
              
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => homeScreen()));
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
class homeScreen extends StatelessWidget {
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
        child: const Text('Welcome to the Anime Watchlist App'),
      ),
    );
  }
}
