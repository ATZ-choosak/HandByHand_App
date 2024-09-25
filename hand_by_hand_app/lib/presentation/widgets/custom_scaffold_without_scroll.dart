import 'package:flutter/material.dart';

class CustomScaffoldWithoutScroll extends StatelessWidget {
  const CustomScaffoldWithoutScroll(
      {super.key,
      required this.child,
      this.appBar,
      this.extendBodyBehindAppBar = true});

  final Widget child;
  final AppBar? appBar;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundColor: Colors.white,
      appBar: appBar,
      body: child,
    );
  }
}
