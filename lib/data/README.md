Adding new api steps

- create file in `lib/data/remote/apis` folder called `<feature-name>.api.dart`
- create enum implements from API abstract class in `lib/data/remote/apis/base.api.dart` and list
  all apis under this feature in this enum with value of paths and methods of the api
  e.g.

```dart
  enum AuthAPI implements API {
  login(url: "/Auth/login", method: Method.post);

  const AuthAPI({
    required this.url,
    required this.method,
  });

  @override
  final String url;
  @override
  final Method method;
}
```

- in your feature repository folder create folder for api models which contains the fields of
  interest for this api and ignore the base ones e.g. for request

```json
{
  "UserName": "sc",
  "Password": "123",
  "DeviceId": "123"
}
```

not

```json
{
  "Request": {
    "UserName": "sc",
    "Password": "123",
    "DeviceId": "123"
  }
}
```

the same for response

- make your repository interface extends from `BaseRepository`
  from `lib/data/base/base_repository.dart` e.g.

```dart
abstract class ILoginRepository extends BaseRepository {
  Future<LoginResponse?> login(LoginRequest request);
}
```

- and call `fetch` function in your repository function implementation for calling the api e.g.

```dart
@override
Future<LoginResponse?> login(LoginRequest request) async {
  return fetch<LoginRequest, LoginResponse>(
      AuthAPI.login, request, LoginResponse.fromJson);
}
```

- `fetch` function takes two types as generic classes one for your request and the other for your
  response `fetch<LoginRequest, LoginResponse>` and takes as a parameters the enum api , request
  object from the first generic type you set and the `fromJson` function of your
  response `fetch<LoginRequest, LoginResponse>(AuthAPI.login, request, LoginResponse.fromJson)`