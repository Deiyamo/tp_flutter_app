part of 'posts_bloc.dart';

enum PostsStatus {
  initial,
  loading,
  success,
  error,
}

class PostsState {
  PostsState({
    this.status = PostsStatus.initial,
    this.posts = const [],
    this.error,
});

  final PostsStatus status;
  final List<Post> posts;
  final String? error;

PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    String? error,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}
