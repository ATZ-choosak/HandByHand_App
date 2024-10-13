import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/category/category_model.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/module/page_route_not_return.dart';
import 'package:hand_by_hand_app/presentation/bloc/item_bloc/bloc/item_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/feed.dart';
import 'package:hand_by_hand_app/presentation/view/item/add_item_steps%20copy/update_item_step_one.dart';
import 'package:hand_by_hand_app/presentation/view/item/add_item_steps%20copy/update_item_step_three.dart';
import 'package:hand_by_hand_app/presentation/view/item/add_item_steps%20copy/update_item_step_two.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_textbutton_stepper.dart';

class UpdateItem extends StatefulWidget {
  final Item item;

  const UpdateItem({
    super.key,
    required this.item,
  });

  @override
  State<UpdateItem> createState() => _ItemState();
}

class _ItemState extends State<UpdateItem> {
  int currentStep = 0;

  // Moved formKey to the class level
  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  int? categoryId;
  List<int>? preferredCategoryIds;
  bool isExchangeable = false;
  bool requireAllCategories = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers and state variables here
    titleController = TextEditingController(text: widget.item.title);
    descriptionController =
        TextEditingController(text: widget.item.description);
    addressController = TextEditingController(text: widget.item.address);

    categoryId = widget.item.category.id;
    preferredCategoryIds = widget.item.preferredCategoryIds;
    isExchangeable = widget.item.isExchangeable;
    requireAllCategories = widget.item.requireAllCategories;
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    titleController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void setCategoryId(int id) {
    setState(() {
      categoryId = id;
    });
  }

  void setExchangeSetting(
      List<int> categorys, bool exchangeable, bool allCategories) {
    setState(() {
      preferredCategoryIds = categorys;
      isExchangeable = exchangeable;
      requireAllCategories = allCategories;
    });
  }

  void continueStep() {
    if (currentStep < 2) {
      if (currentStep > 0) {
        // Validate form before moving to the next step
        if (!formKey.currentState!.validate()) {
          return;
        }
      }

      setState(() {
        currentStep += 1;
      });
    } else {
      context.read<ItemBloc>().add(UpdateItemEvent(
          title: titleController.text,
          description: descriptionController.text,
          categoryId: categoryId!,
          preferredCategoryIds: preferredCategoryIds ?? [],
          isExchangeable: isExchangeable,
          requireAllCategories: requireAllCategories,
          address: addressController.text,
          id: widget.item.id));
    }
  }

  void cancelStep() {
    if (currentStep > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          currentStep -= 1;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CategorySelectedModel> categorys = context.read<ItemBloc>().categorys;

    return CustomScaffoldWithoutScroll(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      child: Stack(
        children: [
          Form(
            key: formKey, // Use the formKey declared at class level
            child: Stepper(
              elevation: 0,
              currentStep: currentStep,
              controller: ScrollController(
                  initialScrollOffset: 0, keepScrollOffset: false),
              type: StepperType.horizontal,
              controlsBuilder: (context, details) {
                return const SizedBox();
              },
              steps: [
                Step(
                  isActive: currentStep >= 0,
                  state:
                      currentStep > 0 ? StepState.complete : StepState.indexed,
                  title: const Text(
                    "ขั้นตอนที่ 1",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const UpdateItemStepOne(),
                ),
                Step(
                  isActive: currentStep >= 1,
                  state:
                      currentStep > 1 ? StepState.complete : StepState.indexed,
                  title: const Text(
                    "ขั้นตอนที่ 2",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: UpdateItemStepTwo(
                    categoryId: categoryId,
                    categoryType: categorys,
                    addressController: addressController,
                    descriptionController: descriptionController,
                    titleController: titleController,
                    setCategoryId: setCategoryId,
                  ),
                ),
                Step(
                  isActive: currentStep >= 2,
                  state:
                      currentStep > 2 ? StepState.complete : StepState.indexed,
                  title: const Text(
                    "ขั้นตอนที่ 3",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: UpdateItemStepThree(
                    categorysRequire: categorys,
                    setExchangeSetting: setExchangeSetting,
                    categoryRequires: preferredCategoryIds ?? [],
                    isExchange: isExchangeable,
                    isRequireAll: requireAllCategories,
                  ),
                ),
              ],
            ),
          ),
          StepController(
            currentStep: currentStep,
            onStepContinue: continueStep,
            onStepCancel: cancelStep,
          ),
        ],
      ),
    );
  }
}

class StepController extends StatelessWidget {
  const StepController({
    super.key,
    required this.currentStep,
    required this.onStepContinue,
    required this.onStepCancel,
  });

  final int currentStep;
  final Function onStepContinue, onStepCancel;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextbuttonStepper(
              disabled: currentStep <= 0,
              submit: onStepCancel,
              buttonText: currentStep <= 0 ? "" : "ย้อนกลับ",
              buttonColor: Theme.of(context).primaryColorLight,
            ),
            BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                if (state is AdditemLoading) {
                  return const CircularProgressIndicator();
                }

                if (state is AdditemSuccess) {
                  pageRouteNotReturn(context, const Feed());
                }

                if (state is AdditemFailure) {
                  AlertMessage.alert("แจ้งเตือน", state.message, context);
                }

                return CustomTextbuttonStepper(
                  submit: onStepContinue,
                  buttonText: currentStep >= 2 ? "เสร็จสิ้น" : "ถัดไป",
                  buttonColor: Theme.of(context).primaryColor,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
