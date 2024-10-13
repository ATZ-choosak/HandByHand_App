import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_by_hand_app/presentation/view/item/add_item_suggest.dart';
import 'package:hand_by_hand_app/presentation/widgets/circle_top.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_button.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_textbutton.dart';
import 'package:hand_by_hand_app/module/page_route.dart';
import 'package:hand_by_hand_app/module/page_route_not_return.dart';
import 'package:hand_by_hand_app/presentation/view/feed.dart';

class FirstAddItem extends StatelessWidget {
  const FirstAddItem({super.key});

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
                  "images/add_item.svg",
                  height: 200,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "เพิ่มรายการของคุณ",
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
                  "ตอนนี้คุณยังไม่มีรายการของใช้ส่วนตัว\nเพิ่มรายการ เพื่อใช้ในการแลกเปลี่ยน",
                  style: TextStyle(fontSize: 14, height: 2),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  submit: () {
                    pageRoute(context, const AddItemSuggest());
                  },
                  buttonText: "เพิ่มเลย",
                  icon: const Icon(Icons.add),
                )
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: CustomTextbutton(
                  buttonText: "ยังไม่ใช่ตอนนี้",
                  submit: () {
                    pageRouteNotReturn(context, const Feed());
                  }))
        ],
      ),
    );
  }
}
