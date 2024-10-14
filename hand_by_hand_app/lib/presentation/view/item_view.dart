import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/presentation/bloc/item_bloc/bloc/item_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:hand_by_hand_app/presentation/widgets/item_card.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ItemBloc>(context).add(GetItemByIdEvent(id: id));

    Item? item;

    return CustomScaffoldWithoutScroll(
      appBar: AppBar(),
      child: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is GetItemByIdSuccess) {
            item = state.item;
          }

          if (state is GetItemLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return item != null ? ItemDetial(item: item) : const SizedBox();
        },
      ),
    );
  }
}

class ItemDetial extends StatelessWidget {
  const ItemDetial({
    super.key,
    required this.item,
  });

  final Item? item;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 80),
        child: item != null
            ? ItemCard(
                item: item!,
                onlyView: true,
              )
            : const SizedBox());
  }
}
