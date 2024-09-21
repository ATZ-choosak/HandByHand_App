import 'package:flutter/material.dart';

class CustomScaffoldWithoutScroll extends StatelessWidget {
  const CustomScaffoldWithoutScroll({
    super.key,
    required this.child,
    this.appBar,
  });

  final Widget child;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: appBar,
      body: child,
    );
  }
}
