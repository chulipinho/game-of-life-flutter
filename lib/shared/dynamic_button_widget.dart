import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DynamicButtonWidget extends StatefulWidget {
  final List<VoidCallback> onTaps;
  final List<Icon> children;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  bool toggle = false;

  DynamicButtonWidget(
      {Key? key,
      required this.onTaps,
      required this.children,
      this.height,
      this.width,
      this.backgroundColor})
      : assert(children.length == 2),
        assert(onTaps.length == 2),
        super(key: key);

  @override
  _DynamicButtonWidgetState createState() => _DynamicButtonWidgetState();
}

class _DynamicButtonWidgetState extends State<DynamicButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Widget child = widget.toggle ? widget.children[0] : widget.children[1];
    VoidCallback onTap = widget.toggle ? widget.onTaps[0] : widget.onTaps[1];

    final backgroundColor =
        widget.backgroundColor ?? Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () {
        widget.toggle = !widget.toggle;
        onTap;
        super.setState(() {});
      },
      child: Container(
        child: child,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
