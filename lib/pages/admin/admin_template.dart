import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/pages/admin/admin_kyc_list_page.dart';
import 'package:gaseng/pages/admin/admin_user_list_page.dart';

class AdminMainTemplate extends StatefulWidget {
  @override
  State<AdminMainTemplate> createState() => _AdminMainTemplateState();
}

class _AdminMainTemplateState extends State<AdminMainTemplate>
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
          AdminKycListPage(),
          AdminUserListPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('images/document.png'), label: 'KYC'),
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
