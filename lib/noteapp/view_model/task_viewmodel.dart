import 'package:riverpod_mvvm_template/noteapp/repository/database_helper.dart';
import 'package:riverpod_mvvm_template/noteapp/repository/model/task_model.dart';

import '../../base/base_state.dart';
import '../../base/base_viewmodel.dart';
import '../../base/base_state_provider.dart';

final taskViewModelProvider = BaseStateProvider<TaskViewState, TaskViewmodel>(
    (ref) => TaskViewmodel(ref.watch(taskRepoProvider)));

class TaskViewState {
  List<Tasks> tasks = [];

  TaskViewState(this.tasks);
}

class TaskViewmodel extends BaseViewModel<TaskViewState> {
  final DatabaseHelper repo;

  TaskViewmodel(this.repo) : super(BaseViewState(data: null));

  getTasks() async {
    try {
      //isLoading = true;
      final response = await repo.getTask();
      //isLoading = false;
      data = TaskViewState(response);
    } catch (e) {
      isLoading = false;
      error = BaseError(e.toString());
    }
  }
  
  Future<void> addTask(Tasks tasks) async {
    try {
      isLoading = true;
      Tasks newTasks = Tasks(title: tasks.title, body: tasks.body);
      await repo.insertTask(newTasks);
      isLoading = false;
      await getTasks();
    } catch (e) {
      isLoading = false;
      error = BaseError(e.toString());
    }
  }

  deleteTask(int id) async {
    try {
      await repo.deleteTask(id);
      await getTasks();
    } catch (e) {
      print(e);
    }
  }

  updateTask(Tasks task) async {
    try {
      isLoading = true;
      await repo.updateTask(task);
      await getTasks();
    } catch (e) {
      //isLoading = false;
      print(e);
    }
  }
}
