import 'package:flutter/material.dart';
import 'package:gaseng/pages/chat/chat_list_page.dart';
import 'package:gaseng/pages/mypage/my_page.dart';
import 'package:gaseng/pages/sharehouse/sharehouse_list_page.dart';

import '../constants/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTemplate extends StatefulWidget {
  @override
  State<MainTemplate> createState() => _MainTemplateState();
}

class _MainTemplateState extends State<MainTemplate>
    with TickerProviderStateMixin {
  late TabController tabController;

  int _focusedIndex = 0;

  @override
  void initState() {
    tabController =
        TabController(length: 4, vsync: this, animationDuration: Duration.zero);
    super.initState();
  }

  void indexListener(int index) {
    setState(() {
      _focusedIndex = index;
      tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _focusedIndex,
        children: [
          SharehouseListPage(),
          ChatListPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('images/home.png'), label: '쉐어하우스'),
          BottomNavigationBarItem(
              icon: Image.asset('images/message.png'), label: '채팅방'),
          BottomNavigationBarItem(
              icon: Image.asset('images/profile.png'), label: '사용자'),
        ],
        currentIndex: _focusedIndex,
        selectedItemColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _focusedIndex = index;
          });
        },
        selectedFontSize: 12.0,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
