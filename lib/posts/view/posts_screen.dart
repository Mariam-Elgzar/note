import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_mvvm_template/base/base_scaffold.dart';
import 'package:riverpod_mvvm_template/posts/view_model/posts_viewmodel.dart';
// import 'package:riverpod_mvvm_template/util/environment.dart';
import '../repository/model/posts_response.dart';

class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(postsViewModelProvider.notifier).getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      viewModel: postsViewModelProvider,
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return PostItem(posts[index]);
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 8),
        itemCount: posts.length,
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // env variable usage
              // Text(
              //   Environment.apiUrl,
              //   style: const TextStyle(color: Colors.red),
              // ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        AssetImage("assets/images/${post.userId}.jpg"),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: screenWidth * .6,
                    child: Text(
                      post.title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  post.body!,
                  style: const TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ));
  }
}
