import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sd/controller/sign_in_bloc/cubit/sign_in_cubit.dart';

class HomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("SDM   "),
        ),
        body: BlocBuilder<SignInCubit, SignInStatus>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(children: <Widget>[
                TextFormField(
                  key: _formKey,
                  controller: _usernameController,
                  decoration: InputDecoration(
                      labelText: "Username",
                      errorText: _formKey.currentState?.validate() ?? false
                          ? 'please enter your username'
                          : null),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your username";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your password";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                if (state == SignInStatus.signUp)
                  TextFormField(
                    decoration: InputDecoration(labelText: "confirm password"),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return "password do not match";
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("please enter value"),
                      ));
                    }
                  },
                  child:
                      Text(state == SignInStatus.login ? "Login" : "Sign Up"),
                ),
                TextButton(
                  onPressed: () {
                    state == SignInStatus.login
                        ? context.read<SignInCubit>().showSignup()
                        : context.read<SignInCubit>().showLogin();
                  },
                  child: Text(state == SignInStatus.login
                      ? "I don't have an account"
                      : 'I already have an account'),
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}
