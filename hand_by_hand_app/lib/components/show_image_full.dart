import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hand_by_hand_app/components/custom_scaffold_without_scroll.dart';

class ShowImageFull extends StatelessWidget {
  const ShowImageFull(
      {super.key, required this.image, required this.removeHandle});

  final File image;
  final Function removeHandle;

  @override
  Widget build(BuildContext context) {
    void removeImage() {
      removeHandle();
      Navigator.pop(context);
    }

    return CustomScaffoldWithoutScroll(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: removeImage,
                  icon: const Icon(
                    Icons.delete,
                  )),
            )
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.black,
                child: Image.file(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ));
  }
}
