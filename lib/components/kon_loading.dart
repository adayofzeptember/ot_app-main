import 'package:flutter/material.dart';
import 'package:ot_app/utils/app_color.dart';

class KonLoadingOverlay {
  BuildContext _context;

  void hide() {
    Navigator.of(_context).pop();
  }

  void show() {
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (ctx) => _FullScreenLoader(),
    );
  }

  // Future<T> during<T>(Future<T> future) {
  //   show();
  //   return future.whenComplete(() => hide());
  // }

  KonLoadingOverlay._create(this._context);

  factory KonLoadingOverlay.of(BuildContext context) {
    return KonLoadingOverlay._create(context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white60),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.blue,
        ),
      ),
    );
  }
}
