import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Widgets/Navigation_bar_Widget.dart';
import '../Anilist_GraphQL/anilist_Oauth.dart';
import '../Repositories/login_user_check.dart';

class LoginWithAnilist extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  LoginWithAnilist({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: () async {
                  bool authrized = await AnlistAuth.authorize();
                  if (authrized) {
                    checkUserCredentials(client.value);

                    // Authorization was successful, navigate to the home screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AppNavigationBar(), // Replace HomeScreen() with your actual home screen widget
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Authorization Error'),
                        content: Text('Failed to authorize'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Login with Anilist'))));
  }
}
