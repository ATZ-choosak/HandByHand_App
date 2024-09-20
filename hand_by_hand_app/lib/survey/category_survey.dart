// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hand_by_hand_app/api/category/category_model.dart';
import 'package:hand_by_hand_app/category_bloc/bloc/category_bloc.dart';
import 'package:hand_by_hand_app/components/custom_button.dart';
import 'package:hand_by_hand_app/components/custom_scaffold.dart';
import 'package:hand_by_hand_app/components/image_filter.dart';
import 'package:hand_by_hand_app/pages/feed.dart';

class CategorySurvey extends StatelessWidget {
  const CategorySurvey({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoryBloc>().add(CategoryLoadingEvent());

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
                      builder: (_) => const Feed(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                });
              }

              if (state is CategorySuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: SizedBox(
                          width: double.infinity,
                          height: 620,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(2),
                            gridDelegate: SliverQuiltedGridDelegate(
                                crossAxisCount: 4,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                                repeatPattern:
                                    QuiltedGridRepeatPattern.inverted,
                                pattern: [
                                  const QuiltedGridTile(1, 2),
                                  const QuiltedGridTile(1, 1),
                                  const QuiltedGridTile(1, 1),
                                ]),
                            itemCount: state.categorys.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                categorys: state.categorys,
                                index: index,
                              );
                            },
                          )),
                    ),
                    CustomButton(
                      disabled: !enableButton(state.categorys),
                      submit: submitCategory,
                      buttonText: "ต่อไป",
                    ),
                  ],
                );
              }

              return SizedBox(
                  width: double.infinity,
                  height: 620,
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
                child: Image.asset(
                  width: double.infinity,
                  height: double.infinity,
                  categorys[index].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    categorys[index].title,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
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
