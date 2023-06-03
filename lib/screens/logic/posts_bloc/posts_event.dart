part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class GetAllPosts extends PostsEvent {
  final int count;

  GetAllPosts(this.count);
}

class AddPost extends PostsEvent {
  final String title;
  final String body;

  AddPost({required this.title, required this.body});
}

class EditPost extends PostsEvent {
  final Post post;

  EditPost(this.post);
}