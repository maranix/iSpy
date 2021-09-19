import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ispy/game/draw_screen.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    Key? key,
    required this.room,
  }) : super(key: key);

  final types.Room room;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final TextEditingController _textFieldController = TextEditingController();
  bool _isAttachmentUploading = false;
  bool _imageSent = false;
  int score = 0;
  int lives = 3;
  bool _isAlive = true;
  String player1 = '';
  String player2 = '';
  String valueText = '';

  void _handleCorrectAnswer() {
    setState(() {
      score++;
      _imageSent = false;
    });
    var result = types.PartialText(
        text: 'You guessed correctly! \n Your score is: $score');
    _handleSendPressed(result);
  }

  void _handleWrongAnswer() {
    if (lives != 1) {
      setState(() {
        lives--;
      });
      var result = types.PartialText(
          text:
              'Uh oh your guess was incorrect! \n Your remaining lives are : $lives');
      _handleSendPressed(result);
    } else {
      var result = const types.PartialText(
          text: 'Uh oh you do not have any lives left.');
      _handleSendPressed(result);

      setState(() {
        _isAlive = false;
        _imageSent = false;
      });
    }
  }

  void _continueGame() {
    setState(() {
      score = 0;
      lives = 3;
      _imageSent = false;
      _isAlive = true;
    });

    // FirebaseFirestore.instance
    //     .collection('rooms')
    //     .doc(widget.room.id)
    //     .collection('messages')
    //     .snapshots()
    //     .forEach(
    //   (element) {
    //     for (QueryDocumentSnapshot snapshot in element.docs) {
    //       snapshot.reference.delete();
    //     }
    //   },
    // );
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Gallery'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    final result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
        );
        _describeObjectDialog(context);
        _setAttachmentUploading(false);
        _imageSent = true;
        _getPlayerIds();
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 95,
      source: ImageSource.camera,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
        );
        _imageSent = true;
        _describeObjectDialog(context);
        _setAttachmentUploading(false);
        _getPlayerIds();
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(types.Message message) async {
    if (message is types.ImageMessage) {
      var localPath = message.uri;

      Get.to(
        () => Draw(localPath: localPath, room: widget.room.id),
      );
    } else if (message is types.FileMessage) {
      var localPath = message.uri;

      Get.to(
        () => Draw(localPath: localPath, room: widget.room.id),
      );
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  void _getPlayerIds() {
    FirebaseChatCore.instance.room(widget.room.id).forEach((element) {
      player1 = element.users[0].id;
      player2 = element.users[1].id;
    });
  }

  Future<void> _describeObjectDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Describe your object'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(
                  hintText: "Use a letter to describe the object"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    var objectDescription = types.PartialText(
                        text:
                            'I spy with my little eye a thing starting with the letter: $valueText');
                    _handleSendPressed(objectDescription);
                    _textFieldController.clear();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Game Lobby'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.stop),
          )
        ],
      ),
      body: StreamBuilder<types.Room>(
        initialData: widget.room,
        stream: FirebaseChatCore.instance.room(widget.room.id),
        builder: (context, snapshot) {
          return StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.messages(snapshot.data!),
            builder: (context, snapshot) {
              _getPlayerIds();
              print(lives);
              return SafeArea(
                bottom: false,
                child: Chat(
                  isAttachmentUploading: _isAttachmentUploading,
                  messages: snapshot.data ?? [],
                  onAttachmentPressed: _handleAtachmentPressed,
                  onMessageTap: _handleMessageTap,
                  onPreviewDataFetched: _handlePreviewDataFetched,
                  onSendPressed: _handleSendPressed,
                  user: types.User(
                    id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                  ),
                  customBottomWidget: _imageSent &&
                          _isAlive &&
                          player1 == FirebaseChatCore.instance.firebaseUser!.uid
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: _handleWrongAnswer,
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: _handleCorrectAnswer,
                                  icon: const Icon(Icons.done),
                                ),
                              ),
                            ],
                          ),
                        )
                      : player1 ==
                                  FirebaseChatCore.instance.firebaseUser!.uid &&
                              lives == 1
                          ? TextButton(
                              onPressed: _continueGame,
                              child: const Text('Continue'),
                            )
                          : const SizedBox(),
                  disableImageGallery: true,
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: _imageSent
          ? const SizedBox()
          : player1 == FirebaseChatCore.instance.firebaseUser!.uid && lives != 1
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.add_a_photo),
                    onPressed: () => {
                      _handleAtachmentPressed(),
                    },
                  ),
                )
              : const SizedBox(),
    );
  }
}
