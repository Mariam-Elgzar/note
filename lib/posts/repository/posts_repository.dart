import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvvm_template/data/remote/apis/posts.api.dart';
import '../../data/remote/api_client.dart';
import 'model/posts_response.dart';

final postsRepositoryProvider =
    Provider((ref) => PostsRepository(ref.watch(apiClientProvider)));

class PostsRepository {
  APIClient apiClient;

  PostsRepository(this.apiClient);

  Future<PostsResponse?> getPosts() async {
    return apiClient.fetch<void, PostsResponse>(
        api: PostsAPI.getPosts, mapper: PostsResponse.fromJson, cache: true);
  }
}
