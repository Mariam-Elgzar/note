class BaseResponse<T> {
  BaseResponse({
    this.response,
  });

  BaseResponse.fromJson(dynamic json,
      {T Function(Map<String, dynamic>?)? mapper}) {
    response = json['Response'] != null
        ? Response.fromJson(json['Response'], mapper: mapper)
        : null;
  }

  Response<T>? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (response != null) {
      map['Response'] = response?.toJson();
    }
    return map;
  }
}

class Response<T> {
  Response({
    this.responseCode,
    this.responseDesc,
    this.requestId,
    this.data,
  });

  Response.fromJson(dynamic json, {T Function(Map<String, dynamic>?)? mapper}) {
    responseCode = json['ResponseCode'];
    responseDesc = json['ResponseDesc'];
    requestId = json['REQUEST-UUID'];
    data = mapper != null
        ? json['Data'] != null
            ? mapper(json['Data'])
            : null
        : json['Data'] as T;
  }

  int? responseCode;
  String? responseDesc;
  String? requestId;
  T? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ResponseCode'] = responseCode;
    map['ResponseDesc'] = responseDesc;
    map['REQUEST-UUID'] = requestId;
    map['Data'] = data;
    return map;
  }
}
