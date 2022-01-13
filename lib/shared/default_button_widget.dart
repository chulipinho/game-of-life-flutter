import 'package:flutter/material.dart';

class DefaultButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  const DefaultButtonWidget(
      {Key? key,
      required this.onTap,
      required this.child,
      this.backgroundColor,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor =
        backgroundColor ?? Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: _backgroundColor, borderRadius: BorderRadius.circular(5)),
        child: Center(child: child),
      ),
    );
  }
}
