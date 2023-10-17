import 'package:flutter/material.dart';

class TopContent extends StatelessWidget {
  final Widget child;
  const TopContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: child,
    );
  }
}

class SideContent extends StatelessWidget {
  final Widget child;
  const SideContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: child,
    );
  }
}

class BottomContent extends StatelessWidget {
  final Widget child;
  const BottomContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
      child: child,
    );
  }
}
