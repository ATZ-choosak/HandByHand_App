// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hand_by_hand_app/data/models/category/category_model.dart';
import 'package:hand_by_hand_app/module/image_path.dart';
import 'package:hand_by_hand_app/presentation/bloc/category_bloc/bloc/category_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/button_loading.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_button.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold.dart';
import 'package:hand_by_hand_app/presentation/widgets/image_filter.dart';
import 'package:hand_by_hand_app/presentation/view/survey/first_add_item.dart';

class CategorySurvey extends StatelessWidget {
  const CategorySurvey({super.key});

  @override
  Widget build(BuildContext context) {
    bool enableButton(List<CategorySelectedModel> categorys) {
      return categorys
              .where(
                (element) => element.selected,
              )
              .length >=
          3;
    }

    void submitCategory() {
      context.read<CategoryBloc>().add(CategorySubmitEvent());
    }

    return CustomScaffold(
        child: Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const HeaderPage(),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategorySubmitSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FirstAddItem(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                });
              }

              if (state is CategorySuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(2),
                      gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                          pattern: [
                            const QuiltedGridTile(1, 2),
                            const QuiltedGridTile(1, 2),
                          ]),
                      itemCount: state.categorys.length,
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          categorys: state.categorys,
                          index: index,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      disabled: !enableButton(state.categorys),
                      submit: submitCategory,
                      buttonText: "ต่อไป",
                    ),
                  ],
                );
              }

              if (state is CategorySubmitLoading) {
                return const ButtonLoading();
              }

              if (state is CategorySubmitFailure) {
                AlertMessage.alert("แจ้งเตือน", state.message, context);
              }

              return SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  )));
            },
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    ));
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categorys,
    required this.index,
  });

  final List<CategorySelectedModel> categorys;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bool selected = categorys[index].selected;

    void onSelected() {
      context
          .read<CategoryBloc>()
          .add(CategorySelectEvent(id: categorys[index].id));
    }

    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: selected
              ? Border.all(
                  color: Theme.of(context).primaryColor,
                  strokeAlign: BorderSide.strokeAlignInside,
                  width: 4,
                )
              : null,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Stack(
          children: [
            ImageFilter(
              brightness: selected ? -150 : -100,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                  Radius.circular(4),
                )),
                child: categorys[index].image != null
                    ? Image.network(
                        imagePath(categorys[index].image!.url),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        width: double.infinity,
                        height: double.infinity,
                        "images/category/fashion.jpg",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            AnimatedContainer(
              width: double.infinity,
              height: double.infinity,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    categorys[index].title,
                    style: TextStyle(
                        color: selected
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderPage extends StatelessWidget {
  const HeaderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "สิ่งที่คุณสนใจตอนนี้",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text("เลือกได้มากกว่า 1 รายการ (เลือกอย่างน้อย 3 รายการ)"),
      ],
    );
  }
}
