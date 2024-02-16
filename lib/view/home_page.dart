import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_auth.dart';
import 'login_page.dart';
class HomeScreen extends StatelessWidget {
  final String _user = FirebaseAuth.instance.currentUser!.uid;
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