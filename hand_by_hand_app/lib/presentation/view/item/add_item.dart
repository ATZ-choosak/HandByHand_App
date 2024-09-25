import 'package:flutter/material.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_textbutton_stepper.dart';
import 'package:hand_by_hand_app/presentation/view/item/steps/add_item_step_one.dart';
import 'package:hand_by_hand_app/presentation/view/item/steps/add_item_step_three.dart';
import 'package:hand_by_hand_app/presentation/view/item/steps/add_item_step_two.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  int currentStep = 0;

  void continueStep() {
    if (currentStep < 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          currentStep += 1;
        });
      });
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
    return CustomScaffoldWithoutScroll(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      child: Stack(
        children: [
          Stepper(
            elevation: 0,
            currentStep: currentStep,
            controller: ScrollController(initialScrollOffset: 0, keepScrollOffset: false),
            type: StepperType.horizontal,
            controlsBuilder: (context, details) {
              return const SizedBox();
            },
            steps: [
              Step(
                isActive: currentStep >= 0,
                state: currentStep > 0 ? StepState.complete : StepState.indexed,
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
                state: currentStep > 1 ? StepState.complete : StepState.indexed,
                title: const Text(
                  "ขั้นตอนที่ 2",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: const AddItemStepTwo(),
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
                content: const AddItemStepThree(),
              ),
            ],
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
      bottom: 20,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextbuttonStepper(
            disabled: currentStep <= 0,
            submit: onStepCancel,
            buttonText: currentStep <= 0 ? "" : "ย้อนกลับ",
            buttonColor: Theme.of(context).primaryColorLight,
          ),
          CustomTextbuttonStepper(
            submit: onStepContinue,
            buttonText: currentStep >= 2 ? "เสร็จสิ้น" : "ถัดไป",
            buttonColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
