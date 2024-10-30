class BaseRequest<T> {
  late T request;

  BaseRequest({
    required this.request,
  });

  BaseRequest.fromJson(dynamic json) {
    request = json['Request'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Request'] = request;
    return map;
  }
}
