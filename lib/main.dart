import 'package:flutter/material.dart';
import 'package:tp_flutter_app/models/post.dart';
import 'package:tp_flutter_app/screens/add_post_screen/add_post_screen.dart';
import 'package:tp_flutter_app/screens/post_detail_screen/post_detail_screen.dart';
import 'package:tp_flutter_app/screens/posts_screen/posts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
