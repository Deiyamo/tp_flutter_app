import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tp_flutter_app/data_sources/posts_data_source.dart';
import 'package:tp_flutter_app/models/post.dart';

class FirestorePostsDataSource extends PostsDataSource {
  final _collection = FirebaseFirestore.instance.collection('posts');

  final StreamController<List<Post>> _postStreamController = StreamController<List<Post>>.broadcast();

  @override
  Stream<List<Post>> getStream() {
    _collection.orderBy('title').snapshots().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final postList = snapshot.docs.map((e) => Post.fromJson(e.data(), e.id)).toList();
        _postStreamController.add(postList);
      }
    });

    return _postStreamController.stream;
  }

  // not used anymore
  Future<List<Post>> get() async {
    try {
      final snapshot = await _collection.orderBy('title').get();

      return snapshot.docs.map((e) => Post.fromJson(e.data(), e.id)).toList();
    } on FirebaseException catch (e) {
      // TODO: Log error
      debugPrint('here');
      throw Exception(e.message);
    }
  }

  @override
  Future<void> add(String title, String body) async {
    try {
      await _collection.add({'title': title, 'body': body});
    } on FirebaseException catch (e) {
      // TODO: Log error
      throw Exception(e.message);
    }
  }

  @override
  Future<void> update(Post post) async {
    try {
      print('post id: ${post.id}');
      await _collection.doc(post.id).update(post.toJson());
    } on FirebaseException catch (e) {
      // TODO: Log error
      throw Exception(e.message);
    }
  }
}
