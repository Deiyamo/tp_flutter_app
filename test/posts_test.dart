import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_app/data_sources/posts_data_source.dart';
import 'package:tp_flutter_app/models/post.dart';

import 'package:tp_flutter_app/repository/posts_repository.dart';
import 'package:tp_flutter_app/screens/logic/posts_bloc/posts_bloc.dart';
import 'package:tp_flutter_app/screens/ui/posts_screen/posts_screen.dart';

class EmptyPostsDataSource extends PostsDataSource {
  final StreamController<List<Post>> _postStreamController = StreamController<List<Post>>();

  @override
  Future<void> add(String title, String body) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Stream<List<Post>> getStream() {
    _postStreamController.add(<Post>[]);
    return _postStreamController.stream;
  }

  @override
  Future<void> update(Post post) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}

class SuccessPostsDataSource extends PostsDataSource {
  final StreamController<List<Post>> _postStreamController = StreamController<List<Post>>();

  @override
  Future<void> add(String title, String body) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Stream<List<Post>> getStream() {
    _postStreamController.add(<Post>[
      Post(id: 'id', title: 'title', body: 'body'),
      Post(id: 'id', title: 'title', body: 'body'),
      Post(id: 'id', title: 'title', body: 'body'),
      Post(id: 'id', title: 'title', body: 'body'),
      Post(id: 'id', title: 'title', body: 'body'),
      Post(id: 'id', title: 'title', body: 'body'),
      Post(id: 'id', title: 'title', body: 'body'),
      Post(id: 'id', title: 'title', body: 'body'),
      Post(id: 'id', title: 'title', body: 'body'),
      Post(id: 'id', title: 'title', body: 'body'),
    ]);
    return _postStreamController.stream;
  }

  @override
  Future<void> update(Post post) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}

class ErrorPostsDataSource extends PostsDataSource {
  @override
  Future<void> add(String title, String body) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Stream<List<Post>> getStream() {
    throw Exception('Error');
  }

  @override
  Future<void> update(Post post) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}

class LoadingPostsDataSource extends PostsDataSource {
  final StreamController<List<Post>> _postStreamController = StreamController<List<Post>>();

  @override
  Future<void> add(String title, String body) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Stream<List<Post>> getStream() {
    return _postStreamController.stream;
  }

  @override
  Future<void> update(Post post) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}

void main() {
  testWidgets('Screen posts with success', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      RepositoryProvider(
        create: (context) => PostsRepository(
          dataSource: SuccessPostsDataSource(),
        ),
        child: BlocProvider(
          create: (context) => PostsBloc(
            repository: RepositoryProvider.of<PostsRepository>(context),
          )..add(GetAllPosts()),
          child: const MaterialApp(
            home: PostsScreen(),
          ),
        ),
      ),
    );

    debugDumpApp();

    await tester.pump();

    final gesture = await tester.startGesture(Offset.zero);
    // Manual scroll
    await gesture.moveBy(const Offset(0, 100));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Screen posts with success empty', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      RepositoryProvider(
        create: (context) => PostsRepository(
          dataSource: EmptyPostsDataSource(),
        ),
        child: BlocProvider(
          create: (context) => PostsBloc(
            repository: RepositoryProvider.of<PostsRepository>(context),
          )..add(GetAllPosts()),
          child: const MaterialApp(
            home: PostsScreen(),
          ),
        ),
      ),
    );

    debugDumpApp();

    await tester.pump();
    expect(find.byType(Column), findsOneWidget);
    expect(find.text('Aucun post n\'a été créé. 😔'), findsWidgets);
  });

  testWidgets('Screen posts with error', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      RepositoryProvider(
        create: (context) => PostsRepository(
          dataSource: ErrorPostsDataSource(),
        ),
        child: BlocProvider(
          create: (context) => PostsBloc(
            repository: RepositoryProvider.of<PostsRepository>(context),
          )..add(GetAllPosts()),
          child: const MaterialApp(
            home: PostsScreen(),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.text('Une erreur est survenue !'), findsWidgets);
  });

  testWidgets('Screen posts with loading', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      RepositoryProvider(
        create: (context) => PostsRepository(
          dataSource: LoadingPostsDataSource(),
        ),
        child: BlocProvider(
          create: (context) => PostsBloc(
            repository: RepositoryProvider.of<PostsRepository>(context),
          )..add(GetAllPosts()),
          child: const MaterialApp(
            home: PostsScreen(),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
