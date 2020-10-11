import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DataProvider with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://coupler-4cb82.appspot.com');

  Future<void> addNewDrawing(String title, File _image) async {
    final String filePath =
        'drawings' + DateTime.now().toString() + '/$title.png';
    final StorageUploadTask uploadTask =
        _storage.ref().child(filePath).putFile(_image);
    final imageURL = await (await uploadTask.onComplete).ref.getDownloadURL();

    await _db.collection('drawings').add({
      'imageUrl': imageURL,
      'time': DateTime.now().toString(),
      'title': title,
      'markers': []
    });
  }
}
