import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ispy/database/model/user.dart';

class Database {
  /// The main Firestore user collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  final uid = FirebaseAuth.instance.currentUser!.uid;

  storeUserData({required String? userName}) async {
    DocumentReference documentReferencer = userCollection.doc(uid);

    Users user = Users(
      uid: uid,
      name: userName,
      presence: true,
    );

    var data = user.toJson();

    await documentReferencer.set(data).whenComplete(() {
      debugPrint("User data added");
    }).catchError((e) => debugPrint(e));
  }

  Stream<QuerySnapshot> retrieveUsers() {
    Stream<QuerySnapshot> queryUsers =
        userCollection.orderBy('name', descending: true).snapshots();

    return queryUsers;
  }

  updateUserPresence() async {
    Map<String, dynamic> presenceStatusTrue = {
      'presence': true,
    };

    await databaseReference
        .child(uid)
        .update(presenceStatusTrue)
        .whenComplete(() => debugPrint('Updated your presence.'))
        .catchError((e) => debugPrint(e));

    Map<String, dynamic> presenceStatusFalse = {
      'presence': false,
    };

    databaseReference.child(uid).onDisconnect().update(presenceStatusFalse);
  }
}
