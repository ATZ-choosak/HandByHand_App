import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/module/image_path.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class PostView extends StatelessWidget {
  const PostView({super.key, required this.index, required this.item});

  final int index;
  final Item item;

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(initialPage: index);

    return CustomScaffoldWithoutScroll(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: item.images.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: Image.network(
                        imagePath(item.images[index].url),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("images/category/fashion.jpg");
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: ReadMoreText(
                    textAlign: TextAlign.start,
                    item.description,
                    trimMode: TrimMode.Line,
                    trimLines: 10,
                    colorClickableText: Theme.of(context).primaryColorLight,
                    trimCollapsedText: " อ่านเพิ่มเติม",
                    trimExpandedText: " อ่านน้อยลง",
                    style: const TextStyle(color: Colors.white),
                    annotations: [
                      Annotation(
                        regExp: RegExp(r'#([a-zA-Z0-9_]+)'),
                        spanBuilder: (
                                {required String text, TextStyle? textStyle}) =>
                            TextSpan(
                          text: text,
                          style: textStyle?.copyWith(color: Colors.blue),
                        ),
                      ),
                      Annotation(
                        regExp: RegExp(r'http[s]?:\/\/[^\s]+'),
                        spanBuilder: (
                                {required String text, TextStyle? textStyle}) =>
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
                ),
              ],
            )
          ],
        ));
  }
}
