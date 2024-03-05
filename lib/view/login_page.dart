import 'package:flutter/material.dart';
import '../repositories/validation.dart';
import 'register_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../Widgets/Navigation_bar_Widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../repositories/anilist_Oauth.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  var username = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: LoginWithAnilist(),
          ),
        ),
      ),
    );
  }
}

// class LoginForm extends StatelessWidget {
//   LoginForm({Key? key}) : super(key: key);

//   final _formKey = GlobalKey<FormState>();

//   final _emailTextController = TextEditingController();

//   final _passwordTextController = TextEditingController();

//   var password = '';

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         // TODO: implement listener
//         if (state is Authenticated) {
//           // Navigate to the authenticated screen
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) => AppNavigationBar()));
//         } else if (state is Unauthenticated) {
//           // Show an error message
//           ScaffoldMessenger.of(context)
//               .showSnackBar(const SnackBar(content: Text('Login Failed')));
//         }
//       },
//       builder: (context, state) {
//         return Form(key:_formKey ,
//         child:Column(
//           children: <Widget>[
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: 'Email Address',
//               ),
//               controller: _emailTextController,
//               validator: (value) => validation.validateEmail(email: value),
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//             ),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//               ),
//               obscureText: true,
//               controller: _passwordTextController,
//               validator: (value) => validation.validatePassword(value: value),
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 print("out of the if statement");
//                 if (_formKey.currentState!.validate()) {
//                   print("inside the if statement");
//                   context.read<AuthBloc>().add(LoginEvent(
//                       email: _emailTextController.text,
//                       password: _passwordTextController.text));
//                 }
//               },
//               child: const Text('Login'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => createAccount()));
//               },
//               child: const Text('Create Account'),
//             ),
//           ],
//         )
//         );
//       },
//     );
//   }
// }
class LoginWithAnilist extends StatelessWidget {
  const LoginWithAnilist({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          bool authrized = await AnlistAuth.authorize();
          if (authrized) {
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
        child: const Text('Login with Anilist'));
  }
}
