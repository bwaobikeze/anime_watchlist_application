import 'package:flutter/material.dart';
import '../repositories/validation.dart';
import 'login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../Widgets/Navigation_bar_Widget.dart';

class createAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body:BlocProvider(
        create: (context) => AuthBloc( ),
        child:  Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: createAccountForm(),
        ),
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
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _usernameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is Authenticated) {
          // Navigate to the authenticated screen
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AppNavigationBar()));
        } else if (state is Unauthenticated) {
          // Show an error message
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login Failed')));
        }
      },
      builder: (context, state) {
        return Form(
            key: _formKey,
            child: Column(
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
                  validator: (value) =>
                      validation.lastNameValidator(lastName: value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  controller: _usernameTextController,
                  validator: (value) =>
                      validation.usernameValidator(username: value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                    controller: _emailTextController,
                    validator: (value) =>
                        validation.validateEmail(email: value),
                    autovalidateMode: AutovalidateMode.onUserInteraction),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  controller: _passwordTextController,
                  validator: (value) =>
                      validation.validatePassword(value: value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(RegisterEvent(
                          email: _emailTextController.text,
                          password: _passwordTextController.text,
                          Name: _nameTextController.text,
                          LastName: _lastNameTextController.text,
                          username: _usernameTextController.text));
                    }
                 
                  },
                  child: const Text('Create Account'),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: const Text('Back to Login')),
              ],
            ));
      },
    );
  }
}
