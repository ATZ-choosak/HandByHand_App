import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hand_by_hand_app/presentation/view/home_page.dart';
import 'package:hand_by_hand_app/presentation/view/profile_page.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithoutScroll(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: GNav(
            //rippleColor: Theme.of(context).primaryColor,
            //hoverColor: Theme.of(context).primaryColor,
            tabBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            activeColor: Theme.of(context).primaryColor,
            color: Theme.of(context).primaryColorDark,
            onTabChange: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "หน้าหลัก",
              ),
              GButton(
                icon: Icons.upload_rounded,
                text: "รายการที่ร้องขอ",
              ),
              GButton(
                icon: Icons.download_rounded,
                text: "รายการที่ถูกขอ",
              ),
              GButton(
                icon: Icons.person,
                text: "โปรไฟล์",
              )
            ],
          ),
        ),
        child: SafeArea(
            top: false,
            child: IndexedStack(
              index: _selectedIndex,
              children: const [HomePage(), Text("2"), Text("3"), ProfilePage()],
            )));
  }
}
