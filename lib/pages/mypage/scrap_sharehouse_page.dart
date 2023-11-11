import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/repositories/scrap_repository.dart';

import 'package:get/get.dart';
import '../../constants/constant.dart';
import '../../models/sharehouse/sharehouse_list_response.dart';

class ScrapSharehousePage extends StatefulWidget {
  const ScrapSharehousePage({Key? key}) : super(key: key);

  @override
  State<ScrapSharehousePage> createState() => _ScrapSharehousePageState();
}

class _ScrapSharehousePageState extends State<ScrapSharehousePage> {
  ScrapRepository scrapRepository = ScrapRepository();
  List<SharehouseListResponse> sharehouses = [];
  late Future future;

  final ScrollController _scrollController = ScrollController();
  final Duration debounceDuration = Duration(milliseconds: 500);
  final double triggerThreshold = 100.0;
  bool isLoading = false;
  Timer? _debounce;

  @override
  void initState() {
    future = getScraps(null);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - triggerThreshold) {
        _handleScrollEnd();
      }
    });
    super.initState();
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
    await getScraps(sharehouses.last.shrId);
    isLoading = false;
  }

  Future<void> getScraps(int? index) async {
    await scrapRepository.getScraps(index, sharehouses);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '스크랩 게시물',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView(
              children: sharehouses.map((sharehouse) {
            return GestureDetector(
              onTap: () {
                Get.toNamed('/sharehouse/detail', arguments: sharehouse.shrId);
              },
              child: ScrapCard(
                title: sharehouse.shrTitle,
                address: sharehouse.shrAddress,
                description: sharehouse.shrDescription,
                imagePath: sharehouse.shrPoster,
              ),
            );
          }).toList());
        },
      ),
    );
  }
}

class ScrapCard extends StatelessWidget {
  ScrapCard({
    required this.title,
    required this.address,
    required this.description,
    required this.imagePath,
  });

  String title;
  String address;
  String description;
  String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: cardShadow),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: gray04,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
                image: DecorationImage(
                  image: NetworkImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      PopupMenuButton(
                        onSelected: (String choice) {
                          if (choice == '삭제') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('정말 삭제하시겠습니까?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('취소'),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('확인'),
                                      onPressed: () async {
                                        Get.back();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        itemBuilder: (BuildContext ctx) {
                          return [
                            _menuItem(text: '삭제', color: Colors.red),
                          ];
                        },
                      ),
                    ],
                  ),
                  Text(address, style: TextStyle(fontSize: 12.0)),
                  SizedBox(height: 8.0),
                  Text(description*10, style: TextStyle(fontSize: 12.0), overflow: TextOverflow.ellipsis,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _menuItem(
      {required String text, Color color = Colors.black}) {
    return PopupMenuItem<String>(
      enabled: true,
      onTap: () {},
      value: text,
      height: 40,
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }
}
