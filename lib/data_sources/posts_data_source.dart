import '../models/post.dart';

abstract class PostsDataSource {
  // Future<List<Post>> get();

  Stream<List<Post>> getStream();

  Future<void> add(String title, String body);

  Future<void> update(Post post);
}