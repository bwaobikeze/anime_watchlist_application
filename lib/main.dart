import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Main function to run the app
Future<void> main() async{
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
      home:LoginScreen(),
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
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: LoginForm(),
          ),
        ),
      );
    }
    
  }
  //Login form
  class LoginForm extends StatelessWidget {
    const LoginForm({Key? key}) : super(key: key);
  
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
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            onChanged: (text) {
              print('Second text field: $text');
            },
          ),
          ElevatedButton(
            onPressed: () {
              print('Login button pressed');
            },
            child: const Text('Login'),
          ),
              ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => createAccount()));
            },
            child: const Text('Create Account'),
          ),
        ],
      );
    }
  }
  //Create account screen
  class createAccount extends StatelessWidget {
    var username = '';
    var password = '';
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Create Account'),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: createAccountForm(),
          ),
        ),
      );
    }
    
  }
  //Create account form
  class createAccountForm extends StatelessWidget {
    const createAccountForm({Key? key}) : super(key: key);
  
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
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            onChanged: (text) {
              print('Second text field: $text');
            },
          ),
          ElevatedButton(
            onPressed: () {
              print('Create Account button pressed');
            },
            child: const Text('Create Account'),
          ),
        ],
      );
    }
  }
  

