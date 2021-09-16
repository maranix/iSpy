// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.username}) : super(key: key);

  final String username;
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
              Text('Welcome, $username'),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
