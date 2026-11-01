import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class AppUpdater extends StatelessWidget {
  const AppUpdater({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: child,
    );
  }
}
