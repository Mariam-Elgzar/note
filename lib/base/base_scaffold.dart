import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'base_state_provider.dart';
import '../util/dialogs.dart';

class BaseScaffold extends ConsumerStatefulWidget {
  const BaseScaffold({
    required this.body,
    required this.viewModel,
    this.padding,
    this.appBar,
    this.faButton,
    Key? key,
  }) : super(key: key);

  final Widget? faButton;
  final Widget body;
  final EdgeInsetsGeometry? padding;
  final BaseStateProvider viewModel;
  final PreferredSizeWidget? appBar;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseScaffold();
}

class _BaseScaffold extends ConsumerState<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    ref.listen(widget.viewModel, (previous, next) {
      if (next.isLoading == true) {
        showLoading();
      }
      if (previous?.isLoading == true && next.isLoading != true) {
        Navigator.pop(context);
      }
      if (next.hasError) showError(next.error!);
    });

    return Scaffold(
      appBar: widget.appBar,
      body: Padding(
        padding: widget.padding ??
            EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
        child: widget.body,
      ),
      floatingActionButton: widget.faButton,
    );
  }
}
