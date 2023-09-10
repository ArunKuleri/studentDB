import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sd/controller/sign_in_bloc/cubit/sign_in_cubit.dart';

class HomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _emailController = TextEditingController();
  DateTime? _selectedDate;
  final List<String> bloodGroups = [
    'A+ve',
    'A-ve',
    'B+ve',
    'B-ve',
    'O+ve',
    'O-ve',
    'AB+ve',
    'AB-ve',
  ];
  String? selectedBloodGroup;
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(" SDM   "),
        ),
        body: BlocBuilder<SignInCubit, SignInStatus>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(children: <Widget>[
                  if (state == SignInStatus.login)
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "Username",
                      ),
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
                  if (state == SignInStatus.login)
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: "password"),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your password";
                        } else if (value.length < 8 ||
                            !value.contains(RegExp(r'/d')) ||
                            !value
                                .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return "Password must be at least 8 characters long and contain at least one number and one special character";
                        }
                        return null;
                      },
                    ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (state == SignInStatus.signUp)
                    TextFormField(
                      controller: _firstNameController,
                      decoration:
                          const InputDecoration(labelText: "First Name"),
                    ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (state == SignInStatus.signUp)
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: "Last Name"),
                    ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (state == SignInStatus.signUp)
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: "password"),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your password";
                        } else if (value.length < 8 ||
                            !value.contains(RegExp(r'/d')) ||
                            !value
                                .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return "Password must be at least 8 characters long and contain at least one number and one special character";
                        }
                        return null;
                      },
                    ),
                  if (state == SignInStatus.signUp)
                    TextFormField(
                      controller: _passwordController,
                      decoration:
                          const InputDecoration(labelText: "confirm password"),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your password";
                        } else if (value.length < 8 ||
                            !value.contains(RegExp(r'/d')) ||
                            !value
                                .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return "Password must be at least 8 characters long and contain at least one number and one special character";
                        }
                        return null;
                      },
                    ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (state == SignInStatus.signUp)
                    TextFormField(
                      controller: _dobController,
                      decoration:
                          const InputDecoration(labelText: "Date of Birth"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "pleaase enter your date of birth";
                        }
                        return null;
                      },
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          _selectedDate = pickedDate;
                          _dobController.text = pickedDate.toString();
                        }
                      },
                    ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (state == SignInStatus.signUp)
                    DropdownButtonFormField<String>(
                      value: selectedBloodGroup,
                      onChanged: (String? newValue) {
                        selectedBloodGroup = newValue;
                      },
                      items: bloodGroups
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        labelText: 'Blood Group',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please select your blood group";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // Save the selected blood group
                        selectedBloodGroup = value;
                      },
                    ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
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
              ),
            );
          },
        ),
      ),
    );
  }
}
