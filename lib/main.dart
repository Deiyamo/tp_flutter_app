import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_app/models/post.dart';
import 'package:tp_flutter_app/screens/logic/posts_bloc/posts_bloc.dart';
import 'package:tp_flutter_app/screens/ui/add_post_screen/add_post_screen.dart';
import 'package:tp_flutter_app/screens/ui/post_detail_screen/post_detail_screen.dart';
import 'package:tp_flutter_app/screens/ui/posts_screen/posts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc()..add(GetAllPosts(4)),
      child: MaterialApp(
        title: 'TP Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
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
    );
  }
}
