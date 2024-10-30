import 'dart:convert';

class PostsResponse {
  List<Post>? posts;

  PostsResponse({this.posts});

  factory PostsResponse.fromJson(dynamic json) {
    Iterable l = json;
    return PostsResponse(
      posts: List<Post>.from(l.map((model) => Post.fromMap(model))),
    );
  }
}

class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromMap(Map<String, dynamic>? data) => Post(
        userId: data?['userId'] as int?,
        id: data?['id'] as int?,
        title: data?['title'] as String?,
        body: data?['body'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Post].
  factory Post.fromJson(String data) {
    return Post.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Post] to a JSON string.
  String toJson() => json.encode(toMap());
}
