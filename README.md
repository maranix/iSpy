# I-SPY

A Flutter application to play [I-Spy](https://www.youtube.com/watch?v=z9d8_IDmNm0) game.
It is a guessing game where one player (the spy or it) chooses an object within their sight and 
announces it to the other players that "I spy with my little eye, something beginning with...", 
naming the first letter of the object. Other players attempt to guess this object by drawing a circle on the image and then sending it back to the player.

## Tech stack
The libraries that this app is using as of now:
- [cupertino_icons](https://pub.dev/packages/cupertino_icons)
- [get](https://pub.dev/packages/get)
- [firebase_core](https://pub.dev/packages/firebase_core)
- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [google_sign_in](https://pub.dev/packages/google_sign_in)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [firebase_database](https://pub.dev/packages/firebase_database)
- [flutter_firebase_chat_core](https://pub.dev/packages/flutter_firebase_chat_core)
- [flutter_chat_ui](https://pub.dev/packages/flutter_chat_ui)
- [open_file](https://pub.dev/packages/open_file)
- [mime](https://pub.dev/packages/mime)
- [file_picker](https://pub.dev/packages/file_picker)
- [firebase_storage](https://pub.dev/packages/firebase_storage)
- [extended_image](https://pub.dev/packages/extended_image)
- [flutter_colorpicker](https://pub.dev/packages/flutter_colorpicker)
- [image_picker](https://pub.dev/packages/image_picker)
- [path_provider](https://pub.dev/packages/path_provider)

The test coverage is _decent_, but not ideal. The app does not have a lot of moving parts, and the business logic end of things is tested properly.

## Run Locally

Make sure that you have flutter and dart installed and setup. If you don't then refer to the official installation instructions at [Flutter Docs](https://flutter.dev/docs/get-started/install)

Then run the following commands

Clone the project

```bash
  git clone https://github.com/ramanverma2k/iSpy
```

Go to the project directory

```bash
  cd iSpy
```

Run the app

```bash
  flutter run
```

## Screenshots
<p align="center">
  <img width="32%" src="assets/screenshots/1.jpg?raw=true">
  <img width="32%" src="assets/screenshots/2.jpg?raw=true">
  <img width="32%" src="assets/screenshots/3.jpg?raw=true">
  <img width="32%" src="assets/screenshots/4.jpg?raw=true">
  <img width="32%" src="assets/screenshots/5.jpg?raw=true">
  <img width="32%" src="assets/screenshots/6.jpg?raw=true">
  <img width="32%" src="assets/screenshots/7.jpg?raw=true">
  <img width="32%" src="assets/screenshots/8.jpg?raw=true">
  <img width="32%" src="assets/screenshots/9.jpg?raw=true">
  <img width="32%" src="assets/screenshots/10.jpg?raw=true">
  <img width="32%" src="assets/screenshots/11.jpg?raw=true">
  <img width="32%" src="assets/screenshots/12.jpg?raw=true">
</p>

## Given Task

To develop a very basic application with functionalities to play I-Spy. It is an assignment to focus only on the given points and functionalities that are mentioned.


## Important points

- Have you ever played i-Spy. We want to create a App version of the same
- What we expect from the App
	- We want to create a user by signing up
	- Show a list of online users once the username is set.
	- You can select one of the user and send him a picture using the camera. Which says "I spy with my little eye a thing starting with the letter ".
	- The other user gets the image and draws a circle around something he thinks is a guess and sends it back to the initial user.
	- If correct they score a point they get 3 tries and the user who sent the first picture selects if its correct or not.
	- They can continue the game or quit.
- Be as creative as possible


## Anit-Requirements:
- You can't do it all. We respect your time and expect that you will have to make choices and tradeoffs for what is in scope for your deliverable.
- Don't worry about authentication. Assume a non-authenticated experience to keep things simple.
- Pick your stack. Choose any libraries that help you produce the highest quality work in the time available.

## License

```
Copyright (c) 2021 Raman Verma

Permission is hereby granted, free of charge, to any
person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the
Software without restriction, including without
limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software
is furnished to do so, subject to the following
conditions:
The above copyright notice and this permission notice
shall be included in all copies or substantial portions
of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF
ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
```