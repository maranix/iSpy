// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ispy/auth/utils/authentication.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    XFile? image, photo;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome, ${user.displayName}'),
              TextButton(
                onPressed: () async => {
                  image = await _picker.pickImage(source: ImageSource.gallery)
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                ),
                child: const Text(
                  'Pick an Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () async => {
                  photo = await _picker.pickImage(source: ImageSource.camera)
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                ),
                child: const Text(
                  'Capture an Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () async => {
                  await Authentication.signOut(context: context),
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                ),
                child: const Text(
                  'Sign out',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
