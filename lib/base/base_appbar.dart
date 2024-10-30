import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget baseAppBar(context, String tittle) {
  return AppBar(
    title: Text(
      tittle,
      style: const TextStyle(color: Colors.black),
    ),
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsetsDirectional.only(start: 25.w),
      child: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xffb49164),
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}
