import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_app/models/post.dart';
import 'package:tp_flutter_app/screens/logic/posts_bloc/posts_bloc.dart';

class PostForm extends StatefulWidget {
  const PostForm({
    super.key,
    this.post,
  });

  final Post? post;

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post?.title ?? '';
    _bodyController.text = widget.post?.body ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            controller: _titleController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Body',
            ),
            controller: _bodyController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {

                  if (widget.post != null) {
                    // Edit Form
                    BlocProvider.of<PostsBloc>(context).add(
                      EditPost(Post(id: widget.post!.id, title: _titleController.text, body: _bodyController.text)),
                    );
                  } else {
                    // Add Form
                    BlocProvider.of<PostsBloc>(context).add(
                      AddPost(title: _titleController.text, body: _bodyController.text),
                    );
                  }
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
