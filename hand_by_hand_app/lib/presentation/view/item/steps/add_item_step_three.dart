import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/additem_bloc/bloc/additem_bloc.dart';
import 'package:hand_by_hand_app/data/models/category/category_model.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddItemStepThree extends StatefulWidget {
  const AddItemStepThree({super.key});

  @override
  State<AddItemStepThree> createState() => _AddItemStepThreeState();
}

class _AddItemStepThreeState extends State<AddItemStepThree> {
  bool? exchange = false, requireAll = false;

  List<int> categoryRequireSelected = [];
  final key = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    List<CategorySelectedModel> categoryRequire =
        context.read<AdditemBloc>().categorysRequire;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "เงื่อนไขการแลกเปลี่ยน",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CustomCheckbox(
                label: "ต้องการแลกเปลี่ยนกับคนอื่น",
                onChanged: (value) {
                  setState(() {
                    exchange = value;
                    if (exchange!) {
                      requireAll = false;
                    }
                  });
                },
                isCheck: exchange,
              ),
              if (exchange!)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: MultiSelectDialogField<int>(
                    key: key,
                    items: categoryRequire
                        .map(
                          (e) => MultiSelectItem<int>(e.id, e.title),
                        )
                        .toList(),
                    onConfirm: (data) {
                      categoryRequireSelected = data;
                      key.currentState?.validate();
                    },
                    buttonText: const Text(
                      "เพิ่มประเภทของที่อยากแลกเปลี่ยนด้วย",
                      style: TextStyle(color: Colors.white),
                    ),
                    buttonIcon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    searchable: true,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    title: const Text("ประเภท"),
                    cancelText: const Text("ยกเลิก"),
                    confirmText: const Text("ตกลง"),
                    selectedItemsTextStyle:
                        const TextStyle(color: Colors.white),
                    selectedColor: Theme.of(context).primaryColor,
                    checkColor: Colors.white,
                    itemsTextStyle:
                        const TextStyle(fontSize: 14, color: Colors.black),
                    searchHint: "ค้นหา",
                    listType: MultiSelectListType.CHIP,
                    chipDisplay: MultiSelectChipDisplay(
                      chipColor: Theme.of(context).primaryColor,
                      textStyle: const TextStyle(color: Colors.white),
                      onTap: (data) {
                        categoryRequireSelected.remove(data);
                        key.currentState?.validate();
                      },
                    ),
                  ),
                )
              else
                const SizedBox(),
              if (exchange!)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      CustomCheckbox(
                        disabled: !exchange!,
                        label:
                            "จะต้องมีครบทุกประเภท (ผู้ที่จะแลกเปลี่ยนกับของชิ้นนี้ จะต้องมีครบทุกประเภทที่ระบุ)",
                        onChanged: (value) {
                          setState(() {
                            requireAll = value;
                          });
                        },
                        isCheck: requireAll,
                      ),
                      if (!requireAll!) Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: const Text(
                                textAlign: TextAlign.start,
                                "กรณีไม่เลือกจะต้องมีครบทุกประเภท ผู้ที่จะแลกของชิ้นนี้ต้องมีอย่างใดอย่างนึงในประเภทที่ระบุ",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ) else const SizedBox(),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: const Text(
                    textAlign: TextAlign.start,
                    "กรณีไม่ต้องการแลกเปลี่ยนกับคนอื่น ของชิ้นนี้จะเป็นการบริจาค",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox(
      {super.key,
      required this.label,
      this.isCheck,
      required this.onChanged,
      this.disabled = false});

  final String label;
  final bool? isCheck;
  final Function(bool?) onChanged;
  final bool disabled;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.isCheck,
          onChanged: widget.disabled ? null : widget.onChanged,
        ),
        Expanded(
            child: Text(
          widget.label,
          style: TextStyle(
              color: widget.disabled
                  ? Theme.of(context).primaryColorDark
                  : Colors.black),
        ))
      ],
    );
  }
}
