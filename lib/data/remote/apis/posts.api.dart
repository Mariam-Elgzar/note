import 'base.api.dart';

enum PostsAPI implements API {
  getPosts(path: "/posts", method: Method.get);

  const PostsAPI({
    required this.path,
    required this.method,
  });

  @override
  final String path;
  @override
  final Method method;
}
