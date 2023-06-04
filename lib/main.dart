import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_app/data_sources/firestore_posts_data_source.dart';
import 'package:tp_flutter_app/models/post.dart';
import 'package:tp_flutter_app/repository/posts_repository.dart';
import 'package:tp_flutter_app/screens/logic/posts_bloc/posts_bloc.dart';
import 'package:tp_flutter_app/screens/ui/add_post_screen/add_post_screen.dart';
import 'package:tp_flutter_app/screens/ui/post_detail_screen/post_detail_screen.dart';
import 'package:tp_flutter_app/screens/ui/posts_screen/posts_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:tp_flutter_app/firebase_options.dart';
import 'package:tp_flutter_app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostsRepository(
        dataSource: FirestorePostsDataSource(),
      ),
      child: BlocProvider(
        create: (context) => PostsBloc(
          repository: RepositoryProvider.of<PostsRepository>(context),
        )..add(GetAllPosts()),
        child: MaterialApp(
          title: 'TP Flutter',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkThemeData,
          routes: {
            '/': (context) => const PostsScreen(),
            AddPostScreen.routeName: (context) => const AddPostScreen(),
          },
          onGenerateRoute: (settings) {
            Widget content = const SizedBox.shrink();

            switch (settings.name) {
              case PostDetailScreen.routeName:
                final arguments = settings.arguments;
                if (arguments is Post) {
                  content = PostDetailScreen(post: arguments);
                }
                break;
            }

            return MaterialPageRoute(
              builder: (context) {
                return content;
              },
            );
          },
        ),
      ),
    );
  }
}
