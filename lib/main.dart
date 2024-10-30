import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_mvvm_template/noteapp/view/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_mvvm_template/util/environment.dart';

// TODO multiple API calls in the same screen
// TODO response data is array: "Data": []
// TODO caching with dio
// TODO url parameter: /users/123
// TODO different base url

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(320, 677),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const Home(),
          );
        });
  }
}
