import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tp_flutter_app/models/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsState()) {
    on<GetAllPosts>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));

      final count = event.count;

      // await Future.delayed(const Duration(seconds: 2));

      try {
        // throw Exception();
        final posts = List.generate(count, (index) => Post(id: index, title: 'Post ${index + 1}', body: 'Body ${index + 1}'));
        emit(state.copyWith(status: PostsStatus.success, posts: posts));
      } catch (error) {
        emit(state.copyWith(status: PostsStatus.error, error: 'Une erreur est survenue !'));
      }

    });

    on<AddPost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));

      final post = Post(id: state.posts.length, title: event.title, body: event.body);

      try {
        await Future.delayed(const Duration(seconds: 2));

        emit(state.copyWith(status: PostsStatus.success, posts: [...state.posts, post]));
      } catch (error) {
        emit(state.copyWith(status: PostsStatus.error, error: 'Une erreur est survenue !'));
      }
    });

    on<EditPost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));

      try {
        await Future.delayed(const Duration(seconds: 2));

        final posts = state.posts;
        final post = event.post;

        debugPrint(post.title);

        debugPrint(posts[2].title);
        posts[posts.indexWhere((element) => element.id == post.id)] = post;
        debugPrint(posts[2].title);

        emit(state.copyWith(status: PostsStatus.success, posts: posts));
      } catch (error) {
        emit(state.copyWith(status: PostsStatus.error, error: 'Une erreur est survenue !'));
      }
    });
  }
}
