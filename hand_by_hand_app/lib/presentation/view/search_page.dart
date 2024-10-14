import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/presentation/bloc/item_bloc/bloc/item_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold.dart';
import 'package:hand_by_hand_app/presentation/widgets/item_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce; // Timer for debounce
  GetAllItemModel allItem = GetAllItemModel(
      items: [], totalItems: 0, page: 1, itemsPerPage: 0, totalPages: 0);

  @override
  void initState() {
    super.initState();

    // Add listener to the text field for search input
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel(); // Dispose the debounce timer
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Set the debounce delay to 500 milliseconds
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Dispatch search event after the debounce delay
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        context.read<ItemBloc>().add(SearchItemEvent(query: query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        title: SizedBox(
          height: 50,
          child: TextField(
            controller: _searchController, // Attach the controller
            textAlignVertical: TextAlignVertical.center,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hintText: "ค้นหา Hand by Hand",
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide.none, // No border
              ),
            ),
          ),
        ),
      ),
      child: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          bool isLoading = false;

          if (state is SearchItemSuccess) {
            allItem = state.allItems;
            isLoading = false;
          }

          if (state is GetItemLoading) {
            isLoading = true;
          }

          if (state is GetItemFailure) {
            AlertMessage.alert("แจ้งเตือน", state.message, context);
            return Center(
              child: TextButton(
                  onPressed: () {
                    context
                        .read<ItemBloc>()
                        .add(GetItemEvent(page: 1, itemPerPage: 10));
                  },
                  child: const Text("โหลดใหม่อีกครั้ง")),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              allItem.items.clear();
              context
                  .read<ItemBloc>()
                  .add(GetItemEvent(page: 1, itemPerPage: 10));
            },
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allItem.items.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < allItem.items.length) {
                  return ItemCard(
                    item: allItem.items[index],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
