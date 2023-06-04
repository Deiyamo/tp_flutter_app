import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_app/models/post.dart';
import 'package:tp_flutter_app/screens/logic/posts_bloc/posts_bloc.dart';
import 'package:tp_flutter_app/widgets/post_form.dart';
import 'package:tp_flutter_app/widgets/post_modal_bottom_sheet.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({
    required this.post,
    super.key,
  });

  final Post post;

  static const routeName = '/PostDetailScreen';

  static void navigateTo(BuildContext context, Post post) {
    Navigator.of(context).pushNamed(routeName, arguments: post);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostsBloc, PostsState>(
      listener: (context, state) {
        if (state.status == PostsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Une erreur est survenue lors de la mise à jour du post.'),
            ),
          );
        }
      },
      child: BlocBuilder<PostsBloc, PostsState>(
        buildWhen: (previous, next) => next.status == PostsStatus.success,
        builder: (context, state) {
          final newPost = state.posts[state.posts.indexWhere((element) => element.id == post.id)];
          return Builder(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(newPost.title),
                    actions: [
                      IconButton(
                        onPressed: () => _showEditPostForm(context),
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(newPost.body),
                      ],
                    ),
                  ),
                );
              }
          );
        },
      ),
    );
  }

  void _showEditPostForm(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (context) {
        return PostModalBottomSheet(
          child: PostForm(post: post),
        );
      },
    );
  }
}
