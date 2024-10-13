import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/category/category_model.dart';
import 'package:hand_by_hand_app/module/page_route_not_return.dart';
import 'package:hand_by_hand_app/presentation/bloc/item_bloc/bloc/item_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/survey/first_add_item_success.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_textbutton_stepper.dart';
import 'package:hand_by_hand_app/presentation/view/item/add_item_steps/add_item_step_one.dart';
import 'package:hand_by_hand_app/presentation/view/item/add_item_steps/add_item_step_three.dart';
import 'package:hand_by_hand_app/presentation/view/item/add_item_steps/add_item_step_two.dart';

class AddItemSuggest extends StatefulWidget {
  const AddItemSuggest({super.key});

  @override
  State<AddItemSuggest> createState() => _ItemState();
}

class _ItemState extends State<AddItemSuggest> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int? categoryId;
  List<int>? preferredCategoryIds;
  bool isExchangeable = false;
  bool requireAllCategories = false;
  final TextEditingController _addressController = TextEditingController();

  void setCategoryId(int id) {
    categoryId = id;
  }

  void setExchangeSetting(
      List<int> categorys, bool exchangeable, bool allCategories) {
    preferredCategoryIds = categorys;
    isExchangeable = exchangeable;
    requireAllCategories = allCategories;
  }

  void continueStep() {
    if (currentStep < 2) {
      if (currentStep > 0) {
        if (!_formKey.currentState!.validate()) {
          return;
        }
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          currentStep += 1;
        });
      });
    } else {
      context.read<ItemBloc>().add(AddItemEvent(
          title: _titleController.text,
          description: _descriptionController.text,
          categoryId: categoryId!,
          preferredCategoryIds: preferredCategoryIds ?? [],
          isExchangeable: isExchangeable,
          requireAllCategories: requireAllCategories,
          address: _addressController.text));
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
            key: _formKey,
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
                  content: const AddItemStepOne(),
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
                  content: AddItemStepTwo(
                    categoryType: categorys,
                    addressController: _addressController,
                    descriptionController: _descriptionController,
                    titleController: _titleController,
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
                  content: AddItemStepThree(
                    categorysRequire: categorys,
                    setExchangeSetting: setExchangeSetting,
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
                  pageRouteNotReturn(context, const FirstAddItemSuccess());
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
