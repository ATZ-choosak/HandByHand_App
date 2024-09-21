import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/additem_bloc/bloc/additem_bloc.dart';
import 'package:hand_by_hand_app/api/category/category_model.dart';
import 'package:hand_by_hand_app/components/custom_input.dart';
import 'package:hand_by_hand_app/components/custom_input_multiline.dart';

class AddItemStepTwo extends StatelessWidget {
  const AddItemStepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    List<CategorySelectedModel> categoryType =
        context.read<AdditemBloc>().categorysType;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "รายละเอียด",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Form(
              child: Column(
            children: [
              CustomInput(
                  inputController: nameController,
                  hintText: "ชื่อรายการ",
                  labelText: "ชื่อ",
                  validateText: "กรุณากรอกชื่อ"),
              const SizedBox(
                height: 20,
              ),
              CustomInput(
                  inputController: nameController,
                  hintText: "สถานที่",
                  labelText: "สถานที่",
                  validateText: "กรุณากรอกสถานที่"),
              const SizedBox(
                height: 20,
              ),
              CustomInputMultiline(
                  minLine: 8,
                  maxLine: 20,
                  inputController: nameController,
                  hintText: "คำอธิบาย...",
                  labelText: "คำอธิบาย",
                  validateText: "กรุณากรอกคำอธิบาย"),
              const SizedBox(
                height: 10,
              ),
              DropdownMenu(
                  width: double.infinity,
                  hintText: "เลือกประเภทของรายการ",
                  onSelected: (value) => print(value),
                  menuHeight: 300,
                  menuStyle: const MenuStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      elevation: WidgetStatePropertyAll(5)),
                  dropdownMenuEntries: categoryType
                      .map(
                        (e) => DropdownMenuEntry(value: e.id, label: e.title),
                      )
                      .toList())
            ],
          )),
        ),
      ],
    );
  }
}
