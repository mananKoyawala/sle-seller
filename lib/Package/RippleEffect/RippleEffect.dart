import 'package:flutter/material.dart';

class RippleContainer extends StatelessWidget {
  const RippleContainer(
      {super.key, this.onTap, this.splashColor, this.radius, this.child});
  final VoidCallback? onTap;
  final Color? splashColor;
  final double? radius;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: splashColor,
      borderRadius: BorderRadius.circular(radius ?? 6),
      child: child,
    );
  }
}
