class Post {
  Post({
    required this.id,
    required this.title,
    required this.body,
  });

  final String id;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json, String id) {
    return Post(
      id: id,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // avoid 'id' field, because we want Firestore create the id for us
    return {
      'title': title,
      'body': body,
    };
  }
}
