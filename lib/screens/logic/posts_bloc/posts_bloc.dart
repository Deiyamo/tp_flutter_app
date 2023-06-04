import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tp_flutter_app/models/post.dart';
import 'package:tp_flutter_app/repository/posts_repository.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository repository;

  PostsBloc({required this.repository}) : super(PostsState()) {
    on<GetAllPosts>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));

      try {
        final postsStream = repository.getPosts();
        await emit.forEach(postsStream, onData: (posts) {
          return state.copyWith(posts: posts, status: PostsStatus.success);
        });
      } catch (error) {
        emit(state.copyWith(status: PostsStatus.error, error: 'Une erreur est survenue !'));
      }
    });

    on<AddPost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));

      try {
        await repository.addPost(title: event.title, body: event.body);
        emit(state.copyWith(status: PostsStatus.success, posts: [...state.posts]));
      } catch (error) {
        emit(state.copyWith(status: PostsStatus.error, error: 'Une erreur est survenue !'));
      }
    });

    on<EditPost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));

      try {
        await repository.editPost(event.post);

        final posts = state.posts;
        final post = event.post;

        debugPrint(post.title);

        debugPrint(posts[2].title);
        posts[posts.indexWhere((element) => element.id == post.id)] = post;
        debugPrint(posts[2].title);

        emit(state.copyWith(status: PostsStatus.success, posts: posts));
      } catch (error) {
        debugPrint(error.toString());
        emit(state.copyWith(status: PostsStatus.error, error: 'Une erreur est survenue !'));
      }
    });
  }
}
