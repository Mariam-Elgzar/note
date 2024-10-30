import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvvm_template/base/base_appbar.dart';
import 'package:riverpod_mvvm_template/base/base_scaffold.dart';
import 'package:riverpod_mvvm_template/noteapp/repository/model/task_model.dart';
import 'package:riverpod_mvvm_template/noteapp/view/showdialog.dart';
import 'package:riverpod_mvvm_template/noteapp/view_model/task_viewmodel.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final ShowAppDialog dialog = ShowAppDialog();
  List<Tasks> tasks = [];

  final List<Color> taskColors = [
    Colors.amber.shade400,
    Colors.amber.shade200,
    Colors.amber.shade300,
    Colors.amber.shade100,
    Colors.orange.shade100,
    Colors.orange.shade200,
    Colors.orange.shade400,
    Colors.orange.shade300,
  ];

  Color randomColorTask(int index) {
    return taskColors[index % taskColors.length];
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(taskViewModelProvider.notifier).getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    tasks = ref.watch(taskViewModelProvider).data?.tasks ?? [];

    return BaseScaffold(
      viewModel: taskViewModelProvider,
      appBar: baseAppBar(context, 'All Tasks'),
      body: tasks.isNotEmpty
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 170,
              ),
              
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final color = randomColorTask(index);
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    width: 180,
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: color,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(
                                task.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                task.body,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: PopupMenuButton<String>(
                            color: Colors.grey.shade300,
                            icon: const Icon(Icons.more_vert),
                            onSelected: (value) {
                              if (value == 'Edit') {
                                dialog.showEditDialog(ref, task);
                                ref.watch(taskViewModelProvider).data?.tasks;
                              } else if (value == 'Delete') {
                                dialog.showDeleteDialog(ref, task);
                                ref.watch(taskViewModelProvider).data?.tasks;
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'Edit',
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 'Delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(child: Text('No Tasks Added Yet!')),
      faButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade400,
        onPressed: () {
          dialog.showAddDialog(ref);
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
