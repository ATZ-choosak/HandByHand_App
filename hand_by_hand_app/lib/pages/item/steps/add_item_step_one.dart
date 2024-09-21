import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddItemStepOne extends StatelessWidget {
  const AddItemStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "เพิ่มรูปภาพ",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text("สามารถเพิ่มได้สูงสุด 6 รูป"),
        const SizedBox(
          height: 20,
        ),
        const AddImageButton(),
        const SizedBox(
          height: 100,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "images/add_item.svg",
                  height: 130,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "ยังไม่มีรูปตอนนี้",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}

class AddImageButton extends StatelessWidget {
  const AddImageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: DottedBorder(
        strokeWidth: 2,
        borderType: BorderType.RRect,
        color: Theme.of(context).primaryColor,
        radius: const Radius.circular(10),
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.camera_alt,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
