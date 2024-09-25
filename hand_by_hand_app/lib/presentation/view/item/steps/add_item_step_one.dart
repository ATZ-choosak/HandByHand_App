import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_by_hand_app/presentation/bloc/additem_bloc/bloc/additem_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/show_image_full.dart';
import 'package:hand_by_hand_app/module/page_route.dart';

class AddItemStepOne extends StatelessWidget {
  const AddItemStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "เพิ่มรูปภาพ",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text("สามารถเพิ่มได้สูงสุด 6 รูป"),
        const SizedBox(
          height: 20,
        ),
        const AddImageButton(),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            BlocBuilder<AdditemBloc, AdditemState>(
              builder: (context, state) {
                if (state is AddImagesFailure) {
                  AlertMessage.alert("แจ้งเตือน", state.message, context);
                  return ImageCard(
                    images: state.images,
                  );
                }

                if (state is AddImagesSuccess) {
                  if (state.images.isEmpty) {
                    return const NoImage();
                  }

                  return ImageCard(
                    images: state.images,
                  );
                }

                return const NoImage();
              },
            )
          ],
        )
      ],
    );
  }
}

class NoImage extends StatelessWidget {
  const NoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "images/add_item.svg",
              height: 130,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "ยังไม่มีรูปตอนนี้",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.images,
  });

  final List<File> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: GridView.builder(
        itemCount: images.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return ImageItem(
            images: images,
            index: index,
          );
        },
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  const ImageItem({
    super.key,
    required this.images,
    required this.index,
  });

  final List<File> images;
  final int index;

  @override
  Widget build(BuildContext context) {
    void removeImage() {
      context.read<AdditemBloc>().add(RemoveImageEvent(image: images[index]));
    }

    return GestureDetector(
      onTap: () => pageRouteWithOutPostFrameCallback(
          context,
          ShowImageFull(
            image: images[index],
            removeHandle: removeImage,
          )),
      child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Image.file(
            images[index],
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          )),
    );
  }
}

class AddImageButton extends StatelessWidget {
  const AddImageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void addImages() {
      context.read<AdditemBloc>().add(AddImageEvent());
    }

    return InkWell(
      onTap: addImages,
      borderRadius: BorderRadius.circular(10),
      child: DottedBorder(
        strokeWidth: 2,
        borderType: BorderType.RRect,
        color: Theme.of(context).primaryColor,
        radius: const Radius.circular(10),
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.camera_alt,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
