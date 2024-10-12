import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_by_hand_app/presentation/view/feed.dart';
import 'package:hand_by_hand_app/presentation/widgets/circle_top.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_button.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:hand_by_hand_app/module/page_route.dart';

class FirstAddItemSuccess extends StatelessWidget {
  const FirstAddItemSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithoutScroll(
      child: Stack(
        children: [
          const CircleTop(),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 120,
                ),
                SvgPicture.asset(
                  "images/success.svg",
                  height: 200,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "เพิ่มรายการสำเร็จ",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  "ตอนนี้คุณมีรายการของใช้ส่วนตัวแล้ว\nค้นหาสิ่งของที่ต้องการเพื่อแลกเปลี่ยนได้เลย",
                  style: TextStyle(fontSize: 14, height: 2),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  submit: () {
                    pageRoute(context, const Feed());
                  },
                  buttonText: "ไปเลย",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
