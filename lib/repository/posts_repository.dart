import 'dart:async';

import 'package:tp_flutter_app/data_sources/posts_data_source.dart';
import 'package:tp_flutter_app/models/post.dart';

class PostsRepository {
  PostsRepository({
    required this.dataSource,
  });

  final PostsDataSource dataSource;

  /*Future<List<Post>> getPosts() async {
    return dataSource.get();
  }*/

  Stream<List<Post>> getPosts() {
    return dataSource.getStream();
  }

  Future<void> addPost({required String title, required String body}) async {
    return dataSource.add(title, body);
  }

  Future<void> editPost(Post post) async {
    return dataSource.update(post);
  }
}
