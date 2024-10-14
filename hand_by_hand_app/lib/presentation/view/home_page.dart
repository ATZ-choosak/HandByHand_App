// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/module/page_route.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/item_bloc/bloc/item_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/item/add_item.dart';
import 'package:hand_by_hand_app/presentation/view/search_page.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:hand_by_hand_app/presentation/widgets/item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  int page = 1;
  int limit = 0;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ItemBloc>(context)
        .add(GetItemEvent(page: 1, itemPerPage: 10));

    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent ==
            scrollController.offset) {
          if (page < limit) {
            page++;
            context
                .read<ItemBloc>()
                .add(GetItemEvent(page: page, itemPerPage: 10));
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    GetAllItemModel allItem = GetAllItemModel(
        items: [], totalItems: 0, page: page, itemsPerPage: 0, totalPages: 0);

    void refreshPage() {
      page = 1;
      allItem.items.clear();
      context.read<ItemBloc>().add(GetItemEvent(page: page, itemPerPage: 10));
    }

    return CustomScaffoldWithoutScroll(
      appBar: AppBar(
        title: const Text("Hand by Hand"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              pageRoute(context, const SearchPage());
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              pageRoute(context, const AddItem());
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              print(state);

              bool isLoading = false;

              if (state is AdditemInitalSuccess) {
                refreshPage();
              }

              if (state is GetItemSuccess) {
                allItem.items.addAll(state.allItems.items);
                limit = state.allItems.totalPages;
                isLoading = false;
              }

              if (state is GetItemLoading) {
                isLoading = true;
              }

              if (state is GetItemFailure) {
                AlertMessage.alert("แจ้งเตือน", state.message, context);
                return Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        refreshPage();
                      },
                      child: const Text("โหลดใหม่อีกครั้ง"),
                    ),
                  ),
                );
              }

              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    refreshPage();
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        const AddItemPanel(),
                        SizedBox(
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                allItem.items.length + (isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < allItem.items.length) {
                                return ItemCard(
                                  item: allItem.items[index],
                                  refreshPage: refreshPage,
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                        if (allItem.items.isEmpty && !isLoading)
                          Center(
                            child: TextButton(
                              onPressed: () {
                                refreshPage();
                              },
                              child: const Text("โหลดอีกครั้ง"),
                            ),
                          )
                        else
                          const SizedBox()
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AddItemPanel extends StatelessWidget {
  const AddItemPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0,
      color: Colors.red,
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
