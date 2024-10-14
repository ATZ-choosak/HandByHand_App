// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/exchange/exchange_model.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/presentation/bloc/chat_bloc/bloc/chat_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/exchange_bloc/bloc/exchange_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/item_bloc/bloc/item_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/button_loading.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_button.dart';
import 'package:hand_by_hand_app/presentation/widgets/profile_image_circle.dart';

class ExchangeDetail extends StatelessWidget {
  const ExchangeDetail({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    context
        .read<ExchangeBloc>()
        .add(CheckRequestExchangeEvent(requestedItemId: item.id));

    return SizedBox(
        width: double.maxFinite,
        child: BlocBuilder<ExchangeBloc, ExchangeState>(
          builder: (context, state) {
            int? offeredItemId;
            bool canExchange = true;
            List<MatchingItem> matchingItems = [];

            if (state is CheckExchangeLoading) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              );
            }

            if (state is CheckEXchangeFailure) {
              AlertMessage.alert("แจ้งเตือน", state.message, context);
            }

            if (state is CheckExchangeSuccess) {
              offeredItemId = state.check.canExchange & item.isExchangeable &&
                      state.check.matchingItems.isNotEmpty
                  ? state.check.matchingItems[0].id
                  : null;
              canExchange = state.check.canExchange;
              matchingItems = state.check.matchingItems;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(item.isExchangeable ? "แลกเปลี่ยน" : "บริจาค")
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                item.isExchangeable && item.preferredCategory.isNotEmpty
                    ? const Column(
                        children: [
                          Text(
                            "ประเภทเงื่อนไขในการแลกเปลี่ยน",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      )
                    : const SizedBox(),
                Wrap(
                  spacing: 2,
                  runSpacing: 2,
                  children: item.preferredCategory
                      .map(
                        (e) => Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).primaryColor),
                            child: Text(
                              e.name,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            )),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                canExchange
                    ? Text(
                        item.isExchangeable
                            ? "คุณสามารถแลกได้"
                            : "สามารถรับของชิ้นนี้ได้",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      )
                    : const Text(
                        "คุณไม่สามารถแลกได้",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                matchingItems.isNotEmpty
                    ? DropdownButtonFormField<int>(
                        validator: (value) {
                          if (value == null) {
                            return "กรุณาเลือกของที่จะแลก";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'เลือกของที่จะแลก',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 15),
                          border:
                              OutlineInputBorder(), // Optional: Adds border to match the form
                        ),
                        value: matchingItems[0]
                            .id, // You can set the initial value here
                        onChanged: (int? value) {
                          offeredItemId = value;
                        },
                        items: matchingItems.map((item) {
                          return DropdownMenuItem<int>(
                            value: item.id,
                            child: Text(item.name),
                          );
                        }).toList(),
                        elevation: 10, // Shadow depth for dropdown menu items
                        dropdownColor:
                            Colors.white, // Background color of dropdown list
                        isExpanded:
                            true, // Makes the dropdown take up full width
                      )
                    : !canExchange
                        ? const Text(
                            "*เนื่องจากคุณไม่มีของที่อยู่ในเงื่อนไขในการแลกเปลี่ยน*")
                        : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<ExchangeBloc, ExchangeState>(
                  builder: (context, stateButton) {
                    print(stateButton);

                    if (stateButton is ExchangeRequestLoading) {
                      return const Center(child: ButtonLoading());
                    }

                    if (stateButton is ExchangeRequestFailure) {
                      AlertMessage.alert(
                          "แจ้งเตือน", stateButton.message, context);
                    }

                    if (stateButton is ExchangeRequestSuccess) {
                      Navigator.pop(context);
                      AlertMessage.alert(
                          "แจ้งเตือน", stateButton.message, context);
                      context.read<ExchangeBloc>().add(ExchangeInitEvent());
                      context.read<ItemBloc>().add(ItemInitalEvent());
                    }

                    return canExchange
                        ? CustomButton(
                            submit: () {
                              context.read<ExchangeBloc>().add(
                                  ExchageRequestEvent(
                                      requestedItemId: item.id,
                                      offeredItemId: item.isExchangeable
                                          ? offeredItemId
                                          : null));
                              context.read<ChatBloc>().add(
                                  CreateChatSessionEvent(
                                      userId: item.owner.id));
                            },
                            buttonText: item.isExchangeable
                                ? "แลกเปลี่ยน"
                                : "ต้องการสิ่งนี้",
                            useIcon: false,
                            width: double.infinity,
                          )
                        : const SizedBox();
                  },
                )
              ],
            );
          },
        ));
  }
}
