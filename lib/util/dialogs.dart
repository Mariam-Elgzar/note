import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/loading_dialog.dart';
import '../base/error_dialog.dart';
import '../base/base_state.dart';

extension Dialogs on ConsumerState {
  void showLoading() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const LoadingDialog();
      },
    );
  }

  void showError(BaseError error) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(
          error: error,
        );
      },
    );
  }
}

extension JsonMapper<T> on String {
  List<T> fromJson(T Function(dynamic) mapper) {
    Iterable l = jsonDecode(this);
    return List<T>.from(l.map((model) => mapper(model)));
  }
}
