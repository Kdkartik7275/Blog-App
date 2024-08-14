import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

Center circularProgress(context) {
  return const Center(
    child: SpinKitFadingCircle(
      size: 40.0,
      color: Colors.white,
    ),
  );
}
