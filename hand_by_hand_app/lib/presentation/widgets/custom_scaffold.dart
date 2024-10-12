import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.child,
    this.appBar, this.bottomNavigationBar,
  });

  final Widget child;
  final Widget? bottomNavigationBar;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavigationBar,
      appBar: appBar,
      body: SingleChildScrollView(
        child: child,
      ),
    );
  }
}
