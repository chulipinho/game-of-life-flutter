import 'package:flutter/material.dart';

class DefaultButtonWidget extends StatelessWidget {
  final bool isDisabled;
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
      this.width,
      this.isDisabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor =
        backgroundColor ?? Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: isDisabled ? Colors.yellow[800] : _backgroundColor,
            borderRadius: BorderRadius.circular(5)),
        child: Center(child: child),
      ),
    );
  }
}
