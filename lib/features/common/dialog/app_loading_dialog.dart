import 'package:flutter/material.dart';

abstract final class AppLoadingDialog {
  static Widget _loadingDialog(BuildContext context) {
    return Row(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(
          width: 8,
        ),
        Container(
          margin: const EdgeInsets.only(left: 7),
          child: Text(
            "Loading...",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  static void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(32.0),
      content: _loadingDialog(context),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void removeLoaderDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
