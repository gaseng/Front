import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/models/sharehouse/sharehouse_response.dart';
import 'package:gaseng/repositories/sharehouse_repository.dart';
import 'package:get/get.dart';

import '../../auth/session_manager.dart';
import '../../constants/constant.dart';
import '../../widgets/sharehouse_card.dart';

class SharehouseListPage extends StatefulWidget {
  @override
  State<SharehouseListPage> createState() => _SharehouseListPageState();
}

class _SharehouseListPageState extends State<SharehouseListPage> {
  SharehouseRepository sharehouseRepository = SharehouseRepository();
  late List<SharehouseResponse> sharehouses;
  Future? future;

  final ScrollController _scrollController = ScrollController();
  final Duration debounceDuration = Duration(milliseconds: 500);
  final double triggerThreshold = 100.0;
  bool isLoading = false;
  Timer? _debounce;

  @override
  void initState() {
    sharehouses = [];
    future = getSharehouse(null);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - triggerThreshold) {
        _handleScrollEnd();
      }
    });
    super.initState();
  }

  Future<void> getSharehouse(int? index) async {
    await sharehouseRepository.getAll(index, sharehouses);
    setState(() {});
  }

  void _handleScrollEnd() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(debounceDuration, () {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        _loadMoreData();
      }
    });
  }

  void _loadMoreData() async {
    isLoading = true;
    await getSharehouse(sharehouses.last.id);
    isLoading = false;
  }

  Future<void> _refreshData() async {
    sharehouses = [];
    await getSharehouse(null);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '쉐어하우스 목록',
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () => Get.toNamed('/sharehouse/notification'),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 16.0),
          ]),
      body: FutureBuilder(
        future: future,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (sharehouses.isEmpty) {
            return Center(child: Text("쉐어하우스가 없습니다."));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: ListView(
                  controller: _scrollController,
                  children: sharehouses.map((sharehouse) {
                    return GestureDetector(
                      onTap: () => Get.toNamed('/sharehouse/detail',
                          arguments: sharehouse.id),
                      child: SharehouseCard(
                        name: sharehouse.name,
                        date: sharehouse.createdAt,
                        title: sharehouse.title,
                        poster: sharehouse.poster,
                        address: sharehouse.address,
                        description: sharehouse.description,
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? status = await SessionManager.getStatus();

          if (status == '승인') {
            Get.toNamed('sharehouse/add');
          } else if (status == '대기') {
            kShowToast('KYC 신청하셨습니다. 승인까지 기다려주세요.');
          } else if (status == '거절') {
            kShowToast('KYC 거절된 이력이 있습니다.');
          } else {
            kShowToast('KYC 등록 후 진행해주세요.');
          }
        },
        child: Icon(
          Icons.add,
          size: 30.0,
          color: Colors.white,
        ),
        backgroundColor: primary,
      ),
    );
  }
}
