import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sd/model/studentdB.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  late final User user;
  EditProfileScreen({required this.user});
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _dobController;
  late TextEditingController _bloodGroupController;
  late TextEditingController _divisionController;
  late ImagePicker _imagePicker;
  PickedFile? _pickedImage = null;
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _dobController = TextEditingController(text: widget.user.dob);
    _bloodGroupController = TextEditingController(text: widget.user.bloodGroup);
    _divisionController = TextEditingController(text: widget.user.division);
    _imagePicker = ImagePicker();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _bloodGroupController.dispose();
    _divisionController.dispose();
    super.dispose();
  }

  Future<void> _SelectProfilePhoto() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = PickedFile(pickedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _SelectProfilePhoto,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _pickedImage != null
                      ? FileImage(File(_pickedImage!.path))
                      : null,
                  child: _pickedImage == null ? const Icon(Icons.person) : null,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'username'),
              ),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: "First Name"),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: "Last Name"),
              ),
              TextField(
                controller: _dobController,
                decoration:
                    const InputDecoration(labelText: "Date of the birth"),
              ),
              TextField(
                controller: _bloodGroupController,
                decoration: const InputDecoration(labelText: "Blood Group"),
              ),
              TextField(
                controller: _divisionController,
                decoration: const InputDecoration(labelText: "Division"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
