import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/exchange/exchange_model.dart';
import 'package:hand_by_hand_app/module/page_route.dart';
import 'package:hand_by_hand_app/module/status_color.dart';
import 'package:hand_by_hand_app/presentation/bloc/exchange_bloc/bloc/exchange_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/item_view.dart';
import 'package:hand_by_hand_app/presentation/view/qrcode_scaner.dart';
import 'package:hand_by_hand_app/presentation/widgets/profile_image_circle.dart';

class OutGoing extends StatelessWidget {
  const OutGoing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ExchangeBloc>(context).add(ExchangeOutgoingEvent());

    List<ExchangeOutGoing> outGoing = [];

    return Column(
      children: [
        BlocBuilder<ExchangeBloc, ExchangeState>(
          builder: (context, state) {
            if (state is ExchangeOutGoingSuccess) {
              outGoing = state.outGoing;
            }

            return Expanded(
                child: RefreshIndicator(
              onRefresh: () async {
                context.read<ExchangeBloc>().add(ExchangeOutgoingEvent());
              },
              child: Container(
                color: outGoing.isEmpty ? Colors.white : Colors.grey[200],
                child: outGoing.isEmpty
                    ? Center(
                        child: TextButton(
                            onPressed: () {
                              context
                                  .read<ExchangeBloc>()
                                  .add(ExchangeOutgoingEvent());
                            },
                            child: const Text("โหลดอีกครั้ง")),
                      )
                    : ListView.builder(
                        itemCount: outGoing.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ProfileImageCircle(
                                              profileImage: outGoing[index]
                                                  .owner
                                                  .profileImage,
                                              name: outGoing[index].owner.name),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            outGoing[index].owner.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Text(outGoing[index].offeredItem != null
                                          ? "แลกเปลี่ยน"
                                          : "บริจาค")
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    outGoing[index].requestedItem.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  outGoing[index].offeredItem != null
                                      ? Row(
                                          children: [
                                            const Text("แลกกับ"),
                                            TextButton(
                                                onPressed: () {
                                                  pageRoute(
                                                      context,
                                                      ItemView(
                                                          id: outGoing[index]
                                                              .offeredItem!
                                                              .id));
                                                },
                                                child: Text(outGoing[index]
                                                    .offeredItem!
                                                    .name))
                                          ],
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: Colors.grey[300],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      outGoing[index].status != "rejected"
                                          ? Row(
                                              children: [
                                                outGoing[index].status ==
                                                        "exchanging"
                                                    ? IconButton(
                                                        onPressed: () {
                                                          pageRoute(
                                                              context,
                                                              QrcodeScaner(
                                                                exchangeId:
                                                                    outGoing[
                                                                            index]
                                                                        .id,
                                                              ));
                                                        },
                                                        icon: const Icon(
                                                            Icons.qr_code))
                                                    : const SizedBox(),
                                              ],
                                            )
                                          : const SizedBox(),
                                      Text(
                                        outGoing[index].status,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: statusColor(
                                                outGoing[index].status)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ));
          },
        )
      ],
    );
  }
}
