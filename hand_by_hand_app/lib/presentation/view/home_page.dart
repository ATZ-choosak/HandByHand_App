// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/module/calculate_different_time.dart';
import 'package:hand_by_hand_app/module/image_path.dart';
import 'package:hand_by_hand_app/module/page_route.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/item_bloc/bloc/item_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/post_view.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:hand_by_hand_app/presentation/widgets/dialog_popup.dart';
import 'package:hand_by_hand_app/presentation/widgets/image_filter.dart';
import 'package:hand_by_hand_app/presentation/widgets/profile_image_circle.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    BlocProvider.of<ItemBloc>(context)
        .add(GetItemEvent(page: 1, itemPerPage: 10));

    return CustomScaffoldWithoutScroll(
        backgroundColor: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(searchController: searchController),
            BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                if (state is GetItemSuccess) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<ItemBloc>()
                            .add(GetItemEvent(page: 1, itemPerPage: 10));
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.allItems.items.length,
                          itemBuilder: (context, index) {
                            return ItemCard(
                              item: state.allItems.items[index],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }

                if (state is GetItemFailure) {
                  AlertMessage.alert("แจ้งเตือน", state.message, context);
                }

                if (state is GetItemLoading) {
                  return Expanded(
                      child: RefreshIndicator(
                          onRefresh: () async {
                            context
                                .read<ItemBloc>()
                                .add(GetItemEvent(page: 1, itemPerPage: 10));
                          },
                          child: const Center(
                              child: CircularProgressIndicator())));
                }

                return Center(
                  child: TextButton(
                      onPressed: () {
                        context
                            .read<ItemBloc>()
                            .add(GetItemEvent(page: 1, itemPerPage: 10));
                      },
                      child: const Text("โหลดใหม่อีกครั้ง")),
                );
              },
            )
          ],
        ));
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    void openImages(int index) {
      pageRoute(
          context,
          PostView(
            index: index,
            item: item,
          ));
    }

    void requireExchange() {
      DialogPopup.show(
          "รายละเอียด",
          ExchangeDetail(
            item: item,
          ),
          () {},
          context);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ProfileImageCircle(
                        profileImage: item.owner.profileImage,
                        name: item.owner.name),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.owner.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          calculateDifferentTime(item.updatedAt),
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
                if (item.isExchangeable)
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Theme.of(context).primaryColor),
                    child: const Text("แลกเปลี่ยน",
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Theme.of(context).primaryColorLight),
                    child: const Text("บริจาค",
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ReadMoreText(
              textAlign: TextAlign.start,
              item.description,
              trimMode: TrimMode.Line,
              trimLines: 4,
              colorClickableText: Theme.of(context).primaryColorLight,
              trimCollapsedText: " อ่านเพิ่มเติม",
              trimExpandedText: " อ่านน้อยลง",
              annotations: [
                Annotation(
                  regExp: RegExp(r'#([a-zA-Z0-9_]+)'),
                  spanBuilder: ({required String text, TextStyle? textStyle}) =>
                      TextSpan(
                    text: text,
                    style: textStyle?.copyWith(color: Colors.blue),
                  ),
                ),
                Annotation(
                  regExp: RegExp(r'http[s]?:\/\/[^\s]+'),
                  spanBuilder: ({required String text, TextStyle? textStyle}) =>
                      TextSpan(
                    text: text,
                    style: textStyle?.copyWith(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        Uri url = Uri.parse(text);
                        await launchUrl(url);
                      },
                  ),
                ),
                // Additional annotations for URLs...
              ],
              moreStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorLight),
              lessStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorLight),
            ),
            Text(
              textAlign: TextAlign.start,
              "#${item.category.name}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            if (item.images.isNotEmpty)
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    crossAxisCount: item.images.length > 1 ? 3 : 1),
                itemCount: item.images.length > 3 ? 3 : item.images.length,
                itemBuilder: (context, index) {
                  if (index == 2) {
                    return Stack(
                      children: [
                        InkWell(
                          onTap: () => openImages(index),
                          child: ImageFilter(
                              brightness: item.images.length <= 3 ? 0 : -80,
                              child: Image.network(
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                imagePath(item.images[index].url),
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                      "images/category/fashion.jpg");
                                },
                              )),
                        ),
                        Center(
                            child: Text(
                          item.images.length == 3
                              ? ""
                              : "+${item.images.length - 3}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        )),
                      ],
                    );
                  }
              
                  return InkWell(
                    onTap: () => openImages(index),
                    child: Image.network(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      imagePath(item.images[index].url),
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset("images/category/fashion.jpg");
                      },
                    ),
                  );
                },
              )
            else
              const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 0.7,
              color: Colors.grey[200],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: requireExchange,
                  style: const ButtonStyle(
                    iconSize: WidgetStatePropertyAll(20),
                  ),
                  label: const Text(
                    "ต้องการสิ่งนี้",
                    style: TextStyle(fontSize: 12),
                  ),
                  icon: const Icon(Icons.favorite_border_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ExchangeDetail extends StatelessWidget {
  const ExchangeDetail({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ชื่อ : ${item.title}"),
          Text("เจ้าของ : ${item.owner.name}"),
          Text("ประเภท : ${item.category.name}"),
          Text("ต้องการ : ${item.isExchangeable ? "แลกเปลี่ยน" : "บริจาค"}"),
          const Text("ประเภทที่ต้องการ :"),
          if (item.isExchangeable)
            SizedBox(
              width: double.maxFinite,
              height: 300,
              child: ListView.builder(
                itemCount: item.preferredCategory.length,
                itemBuilder: (context, index) {
                  return Text(item.preferredCategory[index].name);
                },
              ),
            )
          else
            const SizedBox()
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(GetMeEvent());

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 50),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "HAND BY HAND",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "ค้นหาของที่สนใจ",
              hintStyle: TextStyle(
                  color: Theme.of(context).primaryColorDark, fontSize: 14),
              filled: true,
              suffixIcon: const Icon(Icons.search),
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
