import '../models/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> get();

  Future<void> add(Post post);

  Future<void> update(Post post);
}