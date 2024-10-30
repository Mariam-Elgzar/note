enum Method { post, get }

abstract class API {
  final String path;
  final Method method;

  API(this.path, this.method);
}
