import 'package:flutter/material.dart';
import 'package:hand_by_hand_app/data/models/category/category_model.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_input.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_input_multiline.dart';

class AddItemStepTwo extends StatelessWidget {
  const AddItemStepTwo(
      {super.key,
      required this.categoryType,
      required this.titleController,
      required this.addressController,
      required this.descriptionController,
      required this.setCategoryId});

  final List<CategorySelectedModel> categoryType;
  final TextEditingController titleController;
  final TextEditingController addressController;
  final TextEditingController descriptionController;
  final Function setCategoryId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
            child: Column(
              children: [
                CustomInput(
                    inputController: titleController,
                    hintText: "ชื่อรายการ",
                    labelText: "ชื่อ",
                    validateText: "กรุณากรอกชื่อ"),
                const SizedBox(
                  height: 20,
                ),
                CustomInput(
                    inputController: addressController,
                    hintText: "บ้านเลขที่ 100 ถนน...",
                    labelText: "สถานที่",
                    validateText: "กรุณากรอกสถานที่"),
                const SizedBox(
                  height: 20,
                ),
                CustomInputMultiline(
                    minLine: 8,
                    maxLine: 20,
                    inputController: descriptionController,
                    hintText: "คำอธิบาย...",
                    labelText: "คำอธิบาย",
                    validateText: "กรุณากรอกคำอธิบาย"),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<int>(
                  validator: (value) {
                    if (value == null) {
                      return "กรุณาเลือกประเภทของรายการ";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'เลือกประเภทของรายการ',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    border:
                        OutlineInputBorder(), // Optional: Adds border to match the form
                  ),
                  value: null, // You can set the initial value here
                  onChanged: (int? value) {
                    setCategoryId(value); // Handle selection here
                  },
                  items: categoryType.map((category) {
                    return DropdownMenuItem<int>(
                      value: category.id,
                      child: Text(category.title),
                    );
                  }).toList(),
                  elevation: 10, // Shadow depth for dropdown menu items
                  dropdownColor:
                      Colors.white, // Background color of dropdown list
                  isExpanded: true, // Makes the dropdown take up full width
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
