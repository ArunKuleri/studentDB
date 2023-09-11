import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sd/controller/sign_in_bloc/cubit/sign_in_cubit.dart';
import 'package:sd/model/studentdB.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _dobController = TextEditingController();

  final _emailController = TextEditingController();

  final _selectBloodGroup = TextEditingController();

  final _division = TextEditingController();
  String password = '';
  String email = "";
  String username = "";
  String FirstName = "";
  String LastName = "";
  String DOB = "";
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

  String? selectDivision;

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
                      onSaved: (newValue) {
                        setState(() {
                          username = newValue!;
                        });
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
                        } else if (value.length < 8) {
                          return "Password must be at least 8 characters long ";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        setState(() {
                          password = newValue!;
                        });
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
                      onSaved: (newValue) {
                        setState(() {
                          FirstName = newValue!;
                        });
                      },
                    ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (state == SignInStatus.signUp)
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: "Last Name"),
                      onSaved: (newValue) {
                        setState(() {
                          LastName = newValue!;
                        });
                      },
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
                        } else if (value.length < 8) {
                          return "Password must be at least 8 characters long";
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
                        } else if (value.length < 8) {
                          return "Password must be at least 8 characters";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          password = value!;
                        });
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
                      onSaved: (newValue) {
                        setState(() {
                          DOB = newValue!;
                        });
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
                  if (state == SignInStatus.signUp)
                    DropdownButtonFormField<String>(
                      value: selectDivision,
                      onChanged: (String? newValue) {
                        selectDivision = newValue;
                      },
                      items: ['A', 'B', 'C', 'D', 'E']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      decoration: const InputDecoration(
                        labelText: "Division",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please select a division";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        selectDivision = value;
                      },
                    ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final user = User(
                          username: _usernameController.text,
                          password: _passwordController.text,
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          dob: _dobController.text,
                          bloodGroup: _selectBloodGroup.text,
                          division: _division.text,
                        );
                        final dbHelper = DatabaseHelper();
                        final userId = await dbHelper.insertUser(user);
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
