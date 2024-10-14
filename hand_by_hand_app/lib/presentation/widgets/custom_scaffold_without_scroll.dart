import 'package:flutter/material.dart';

class CustomScaffoldWithoutScroll extends StatelessWidget {
  const CustomScaffoldWithoutScroll(
      {super.key,
      required this.child,
      this.appBar,
      this.extendBodyBehindAppBar = true,
      this.bottomNavigationBar,
      this.backgroundColor = Colors.white,
      this.resizeToAvoidBottomInset = false});

  final Widget child;
  final Widget? bottomNavigationBar;
  final AppBar? appBar;
  final Color? backgroundColor;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomNavigationBar,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: child,
    );
  }
}
