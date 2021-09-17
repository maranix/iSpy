import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ispy/auth/utils/textcontroller.dart';
import 'package:ispy/home/home_page.dart';

class UserNamePage extends StatelessWidget {
  const UserNamePage({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    final ControllerText _text = ControllerText();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hey!',
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10),
            Text(
                'Your current username is ${user.displayName}, enter a new username to change it.'),
            const SizedBox(height: 10),
            const Text(
                'Pick a suitable username for yourself and let\'s get started'),
            const SizedBox(height: 40),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  hintText: 'Username',
                ),
                controller: _text.controller,
                onChanged: (value) => {_text.controllerText.value = value},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () => {
                if (_text.controllerText.value.isNotEmpty)
                  user.updateDisplayName(_text.controllerText.value),
                Get.off(
                  () => HomePage(user: user),
                ),
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              ),
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
