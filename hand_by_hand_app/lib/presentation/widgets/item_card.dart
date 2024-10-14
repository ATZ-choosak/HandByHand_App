import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/data/models/user/user_model.dart';
import 'package:hand_by_hand_app/module/calculate_different_time.dart';
import 'package:hand_by_hand_app/module/calculate_distance.dart';
import 'package:hand_by_hand_app/module/image_path.dart';
import 'package:hand_by_hand_app/module/page_route.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/post_view.dart';
import 'package:hand_by_hand_app/presentation/widgets/dialog_popup.dart';
import 'package:hand_by_hand_app/presentation/widgets/exchage_detail.dart';
import 'package:hand_by_hand_app/presentation/widgets/image_filter.dart';
import 'package:hand_by_hand_app/presentation/widgets/profile_image_circle.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
    this.refreshPage,
    this.onlyView = false,
  });

  final Item item;
  final Function? refreshPage;
  final bool? onlyView;

  @override
  Widget build(BuildContext context) {
    UserGetMe me = BlocProvider.of<AuthBloc>(context).me;

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
          null,
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
                        FutureBuilder<String>(
                          future: calculateDistance(item.lat, item.lon),
                          builder: (context, snapshot) {
                            return Text(
                              "${calculateDifferentTime(item.updatedAt)}${snapshot.hasData ? " · ${snapshot.data} กม." : ""}",
                              style: const TextStyle(fontSize: 12),
                            );
                          },
                        ),
                        Text("${item.title} . ${item.address}",
                            style: const TextStyle(fontSize: 10))
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
            !onlyView!
                ? Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 0.7,
                        color: Colors.grey[200],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          me.id != item.owner.id
                              ? TextButton.icon(
                                  onPressed: requireExchange,
                                  style: const ButtonStyle(
                                    iconSize: WidgetStatePropertyAll(20),
                                  ),
                                  label: const Text(
                                    "ต้องการสิ่งนี้",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  icon: const Icon(
                                      Icons.favorite_border_outlined),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
