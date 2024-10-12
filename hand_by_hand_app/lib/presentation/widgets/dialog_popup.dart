import 'package:flutter/material.dart';

class DialogPopup {
  DialogPopup.show(
      String title, Widget content, Function confirm, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                title: Text(title),
                content: content,
                actions: [
                  TextButton(
                    onPressed: () => confirm,
                    child: Text(
                      "ตกลง",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "ยกเลิก",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ));
    });
  }
}
