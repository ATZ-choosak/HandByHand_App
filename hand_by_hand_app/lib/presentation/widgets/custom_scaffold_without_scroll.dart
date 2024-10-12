import 'package:flutter/material.dart';

class CustomScaffoldWithoutScroll extends StatelessWidget {
  const CustomScaffoldWithoutScroll(
      {super.key,
      required this.child,
      this.appBar,
      this.extendBodyBehindAppBar = true,
      this.bottomNavigationBar,
      this.backgroundColor = Colors.white});

  final Widget child;
  final Widget? bottomNavigationBar;
  final AppBar? appBar;
  final Color? backgroundColor;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: bottomNavigationBar,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: child,
    );
  }
}
