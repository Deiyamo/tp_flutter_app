import 'package:tp_flutter_app/data_sources/posts_data_source.dart';
import 'package:tp_flutter_app/models/post.dart';

class PostsRepository {
  PostsRepository({
    required this.dataSource,
  });

  final PostsDataSource dataSource;

  Future<List<Post>> getPosts() async {
    return dataSource.get();
  }

  Future<void> addPost(Post post) async {
    return dataSource.add(post);
  }

  Future<void> editPost(Post post) async {
    return dataSource.update(post);
  }
}
