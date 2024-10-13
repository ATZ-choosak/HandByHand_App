import 'package:flutter/material.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return CustomScaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        title: SizedBox(
          height: 50,
          child: TextField(
            controller: searchController,
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
      child: const Text("test"),
    );
  }
}
