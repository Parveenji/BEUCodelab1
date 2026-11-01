import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppWidgetLoading extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const AppWidgetLoading({
    super.key,
    required this.child,
    this.isLoading = true,
  });

  static Widget roundedRectangularSkeleton({
    required double height,
    double width = double.maxFinite,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
    );
  }

  static Widget textSkeleton({
    required String text,
    double fontSize = 24,
  }) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize),
    );
  }

  static Widget circularSkeleton({
    required double radius,
    double width = double.maxFinite,
  }) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;
    return Shimmer.fromColors(
      baseColor: Theme.of(context).hoverColor,
      highlightColor: Theme.of(context).canvasColor,
      child: child,
    );
  }
}
