import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvvm_template/noteapp/repository/model/task_model.dart';
import 'package:riverpod_mvvm_template/noteapp/view_model/task_viewmodel.dart';

class ShowAppDialog {
  final _formKey = GlobalKey<FormState>();
  void showAddDialog(WidgetRef ref) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showDialog(
        context: ref.context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.amber.shade400,
            title: Text(
              'Add contact',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'title'),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'body';
                    //   }
                    //   if (int.tryParse(value) == null) {
                    //     return 'Please enter a valid phone number';
                    //   }
                    //   return null;
                    // },
                    controller: bodyController,
                    decoration: InputDecoration(labelText: 'body'),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Tasks tasks = Tasks(
                          title: titleController.text,
                          body: bodyController.text);
                      ref.read(taskViewModelProvider.notifier).addTask(tasks);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'save',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ))
            ],
          );
        });
  }

  void showEditDialog(WidgetRef ref, Tasks tasks) {
    final titleController = TextEditingController(text: tasks.title);
    final bodyController = TextEditingController(text: tasks.body);

    showDialog(
      context: ref.context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            backgroundColor: Colors.amber.shade400,
            title: Text(
              'Edit Item',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title';
                    }
                    return null;
                  },
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'title'),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter phone';
                  //   }
                  //   return null;
                  // },
                  controller: bodyController,
                  decoration: InputDecoration(labelText: 'body'),
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    tasks.title = titleController.text;
                    tasks.body = bodyController.text;

                    ref.read(taskViewModelProvider.notifier).updateTask(tasks);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Update',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showDeleteDialog(WidgetRef ref, Tasks tasks) {
    showDialog(
        context: ref.context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.amber.shade400,
            title: Text(
              'Delete this task',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text('do you want to delete this task?!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'cancel',
                    style: TextStyle(color: Colors.blue),
                  )),
              TextButton(
                  onPressed: () {
                    ref
                        .read(taskViewModelProvider.notifier)
                        .deleteTask(tasks.id!);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'delete',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }
}
