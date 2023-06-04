import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_app/models/post.dart';
import 'package:tp_flutter_app/screens/logic/posts_bloc/posts_bloc.dart';
import 'package:tp_flutter_app/screens/ui/post_detail_screen/post_detail_screen.dart';
import 'package:tp_flutter_app/widgets/post_form.dart';
import 'package:tp_flutter_app/widgets/post_modal_bottom_sheet.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostsStatus.initial:
              return const SizedBox();
            case PostsStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostsStatus.error:
              return Center(
                child: Text('${state.error}'),
              );
            case PostsStatus.success:
              final posts = state.posts;

              if (posts.isEmpty) {
                return Center(
                  child: Column(
                    children: const [
                      Text('Aucun post n\'a été créé. 😔'),
                      Text('Veuillez créer votre premier post !'),
                    ],
                  ),
                );
              }

              // final query = FirebaseFirestore.instance.collection('posts').orderBy('title');
              /*return FirestoreListView(
                query: query,
                itemBuilder: (context, snapshot) {
                  final post = Post.fromJson(snapshot.data(), snapshot.id);
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                    onTap: () => _onPostTap(context, post),
                  );
                },
              );*/

              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                    onTap: () => _onPostTap(context, post),
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostForm(context),
        child: const Icon(Icons.edit_note),
      ),
    );
  }

  void _onPostTap(BuildContext context, Post post) {
    PostDetailScreen.navigateTo(context, post);
  }

  void _showAddPostForm(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (context) {
        return const PostModalBottomSheet(
          child: PostForm(),
        );
      },
    );
  }
}
