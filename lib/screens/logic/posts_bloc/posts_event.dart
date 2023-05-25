part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class GetAllPosts extends PostsEvent {
  final int count;

  GetAllPosts(this.count);
}

class AddPost extends PostsEvent {
  final Post post;

  AddPost(this.post);
}

class EditPost extends PostsEvent {
  final Post post;

  EditPost(this.post);
}