import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/additem_bloc/bloc/additem_bloc.dart';
import 'package:hand_by_hand_app/api/category/category_model.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddItemStepThree extends StatefulWidget {
  const AddItemStepThree({super.key});

  @override
  State<AddItemStepThree> createState() => _AddItemStepThreeState();
}

class _AddItemStepThreeState extends State<AddItemStepThree> {
  bool? notExchange = false, requireAll = false;

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
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CustomCheckbox(
                label: "ไม่มีเงื่อนไขในการแลกเปลี่ยน",
                onChanged: (value) {
                  setState(() {
                    notExchange = value;
                    if (notExchange!) {
                      requireAll = false;
                    }
                  });
                },
                isCheck: notExchange,
              ),
              if (!notExchange!)
                CustomCheckbox(
                  disabled: notExchange!,
                  label:
                      "จะต้องมีครบทุกเงื่อนไข (ผู้ที่จะแลกเปลี่ยนกับสิ่งของนี้ จะต้องมีครบทุกประเภทที่ระบุ)",
                  onChanged: (value) {
                    setState(() {
                      requireAll = value;
                    });
                  },
                  isCheck: requireAll,
                )
              else
                const SizedBox(),
              const SizedBox(
                height: 20,
              ),
              if (!notExchange!)
                MultiSelectDialogField<int>(
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
                  buttonText: const Text("เลือกประเภทที่ต้องการแลกเปลี่ยน"),
                  searchable: true,
                  title: const Text("ประเภท"),
                  cancelText: const Text("ยกเลิก"),
                  confirmText: const Text("ตกลง"),
                  selectedItemsTextStyle: const TextStyle(color: Colors.white),
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
                )
              else
                const SizedBox()
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
