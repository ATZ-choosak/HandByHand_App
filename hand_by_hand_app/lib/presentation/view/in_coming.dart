import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/exchange/exchange_model.dart';
import 'package:hand_by_hand_app/module/page_route.dart';
import 'package:hand_by_hand_app/module/status_color.dart';
import 'package:hand_by_hand_app/presentation/bloc/exchange_bloc/bloc/exchange_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/item_view.dart';
import 'package:hand_by_hand_app/presentation/view/qrcode_view.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/profile_image_circle.dart';

class InComing extends StatelessWidget {
  const InComing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ExchangeBloc>(context).add(ExchangeInComingEvent());

    List<ExchangeInComing> inComing = [];

    return Column(
      children: [
        BlocBuilder<ExchangeBloc, ExchangeState>(
          builder: (context, state) {
            if (state is ExchangeInComingSuccess) {
              inComing = state.incoming;
            }

            if (state is ExchangeAcceptSuccess) {
              AlertMessage.alert("แจ้งเตือน", state.message, context);
              context.read<ExchangeBloc>().add(ExchangeInComingEvent());
            }

            if (state is ExchangeRejectSuccess) {
              AlertMessage.alert("แจ้งเตือน", state.message, context);
              context.read<ExchangeBloc>().add(ExchangeInComingEvent());
            }

            return Expanded(
                child: RefreshIndicator(
              onRefresh: () async {
                context.read<ExchangeBloc>().add(ExchangeInComingEvent());
              },
              child: Container(
                color: inComing.isEmpty ? Colors.white : Colors.grey[200],
                child: inComing.isEmpty
                    ? Center(
                        child: TextButton(
                            onPressed: () {
                              context
                                  .read<ExchangeBloc>()
                                  .add(ExchangeInComingEvent());
                            },
                            child: const Text("โหลดอีกครั้ง")),
                      )
                    : ListView.builder(
                        itemCount: inComing.length,
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
                                              profileImage: inComing[index]
                                                  .requester
                                                  .profileImage,
                                              name: inComing[index]
                                                  .requester
                                                  .name),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            inComing[index].requester.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Text(inComing[index].offeredItem != null
                                          ? "แลกเปลี่ยน"
                                          : "บริจาค")
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    inComing[index].requestedItem.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  inComing[index].offeredItem != null
                                      ? Row(
                                          children: [
                                            const Text("แลกกับ"),
                                            TextButton(
                                                onPressed: () {
                                                  pageRoute(
                                                      context,
                                                      ItemView(
                                                          id: inComing[index]
                                                              .offeredItem!
                                                              .id));
                                                },
                                                child: Text(inComing[index]
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
                                      inComing[index].status != "rejected" &&
                                              inComing[index].status !=
                                                  "completed"
                                          ? Row(
                                              children: [
                                                inComing[index].status !=
                                                        "exchanging"
                                                    ? Row(
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        ExchangeBloc>()
                                                                    .add(ExchangeAcceptEvent(
                                                                        exchangeId:
                                                                            inComing[index].id));
                                                              },
                                                              icon: const Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .greenAccent,
                                                              )),
                                                          IconButton(
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        ExchangeBloc>()
                                                                    .add(ExchangeRejectEvent(
                                                                        exchangeId:
                                                                            inComing[index].id));
                                                              },
                                                              icon: const Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .redAccent,
                                                              )),
                                                        ],
                                                      )
                                                    : IconButton(
                                                        onPressed: () {
                                                          pageRoute(
                                                              context,
                                                              QrcodeView(
                                                                exchange:
                                                                    inComing[
                                                                        index],
                                                              ));
                                                        },
                                                        icon: const Icon(
                                                          Icons.qr_code,
                                                        ))
                                              ],
                                            )
                                          : const SizedBox(),
                                      Text(
                                        inComing[index].status,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: statusColor(
                                                inComing[index].status)),
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
        ),
      ],
    );
  }
}
