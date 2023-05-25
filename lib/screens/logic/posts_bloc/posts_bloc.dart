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

      // await Future.delayed(Duration(seconds: 2));

      try {
        // throw Exception();
        final posts = List.generate(count, (index) => Post(title: 'Post $index', body: 'Body $index'));
        emit(state.copyWith(status: PostsStatus.success, posts: posts));
      } catch (error) {
        emit(state.copyWith(status: PostsStatus.error, error: 'Une erreur est survenue !'));
      }

    });

    on<AddPost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));


    });

    on<EditPost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));


    });
  }
}
