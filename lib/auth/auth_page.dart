import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const Text(
                'Pick a suitable username for yourself and let\'s get started'),
            const SizedBox(height: 40),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const UsernameFormField(),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () => {},
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

class UsernameFormField extends StatefulWidget {
  const UsernameFormField({Key? key}) : super(key: key);

  @override
  _UsernameFormFieldState createState() => _UsernameFormFieldState();
}

class _UsernameFormFieldState extends State<UsernameFormField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        hintText: 'Username',
      ),
      controller: _controller,
      onChanged: (value) => {
        setState(() {
          debugPrint(value);
        })
      },
    );
  }
}
