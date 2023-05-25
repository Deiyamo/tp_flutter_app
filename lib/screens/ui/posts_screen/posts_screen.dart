import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_app/screens/logic/posts_bloc/posts_bloc.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc()..add(GetAllPosts(4)),
      child: Builder(
        builder: (context) {
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

                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Post $index'),
                          subtitle: Text('Body $index'),
                          onTap: () {},
                        );
                      },
                    );
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.edit_note),
            ),
          );
        }
      ),
    );
  }
}
