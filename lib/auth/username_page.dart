import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:ispy/auth/utils/textcontroller.dart';
import 'package:ispy/home/home_page.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class UserNamePage extends StatelessWidget {
  const UserNamePage({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    final ControllerText _text = ControllerText();
    Map<String, dynamic> metadata = {
      "presense": true,
    };

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hey There!',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        children: [
                          const TextSpan(text: 'Your current username is '),
                          TextSpan(
                            text: '${user.displayName},\n',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                              text: 'Enter a new username to change it.')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
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
              onPressed: () async => {
                if (_text.controllerText.value.isNotEmpty)
                  {
                    user.updateDisplayName(_text.controllerText.value),
                  }
                else
                  {
                    _text.controllerText.value = user.displayName as String,
                  },
                await FirebaseChatCore.instance.createUserInFirestore(
                  types.User(
                    firstName: _text.controllerText.value,
                    id: user.uid,
                    metadata: metadata,
                  ),
                ),
                Get.off(
                  () => HomePage(username: _text.controllerText.value),
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
