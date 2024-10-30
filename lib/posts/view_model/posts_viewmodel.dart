import '../../base/base_state.dart';
import '../../base/base_viewmodel.dart';
import '../../base/base_state_provider.dart';
import '../repository/posts_repository.dart';
import '../repository/model/posts_response.dart';

final postsViewModelProvider =
    BaseStateProvider<PostsViewState, PostsViewModel>(
        (ref) => PostsViewModel(ref.watch(postsRepositoryProvider)));

class PostsViewState {
  final List<Post> posts;

  PostsViewState(this.posts);
}

class PostsViewModel extends BaseViewModel<PostsViewState> {
  final PostsRepository repo;

  PostsViewModel(this.repo) : super(BaseViewState(data: null));

  getPosts() async {
    try {
      isLoading = true;
      final response = await repo.getPosts();

      isLoading = false;
      response?.posts?.shuffle();
      data = PostsViewState(response?.posts ?? []);
    } catch (e) {
      isLoading = false;
      error = BaseError(e.toString());
    }
  }
}
