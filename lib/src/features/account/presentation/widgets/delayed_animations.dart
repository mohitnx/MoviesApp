import 'dart:async';

import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int? delay;

  DelayedAnimation({required this.child, this.delay});

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<Offset>? animOffset;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    final curve = CurvedAnimation(curve: Curves.ease, parent: controller!);
    animOffset = Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
        .animate(curve);

    if (widget.delay == null) {
      controller!.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay!), () {
        if (mounted) {
          controller!.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller!,
      child: SlideTransition(
        position: animOffset!,
        child: widget.child,
      ),
    );
  }
}
