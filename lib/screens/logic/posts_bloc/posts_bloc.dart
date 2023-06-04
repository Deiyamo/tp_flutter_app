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
        final posts = await repository.getPosts();
        // final posts = List.generate(count, (index) => Post(id: index, title: 'Post ${index + 1}', body: 'Body ${index + 1}'));
        emit(state.copyWith(status: PostsStatus.success, posts: posts));
      } catch (error) {
        print('bloc');
        debugPrint(error.toString());
        emit(state.copyWith(status: PostsStatus.error, error: 'Une erreur est survenue !'));
      }

    });

    on<AddPost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));

      final post = Post(id: '', title: event.title, body: event.body);

      try {
        await repository.addPost(post);

        emit(state.copyWith(status: PostsStatus.success, posts: [...state.posts, post]));
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
        debugPrint('bloc edit');
        debugPrint(error.toString());
        emit(state.copyWith(status: PostsStatus.error, error: 'Une erreur est survenue !'));
      }
    });
  }
}
