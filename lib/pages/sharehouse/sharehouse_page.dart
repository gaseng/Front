import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/auth/session_manager.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:gaseng/models/chat/chat_room_create_response.dart';
import 'package:gaseng/enum/checklist_enum.dart';
import 'package:gaseng/models/sharehouse/sharehouse_detail_response.dart';
import 'package:gaseng/repositories/chat_repository.dart';
import 'package:gaseng/repositories/scrap_repository.dart';
import 'package:gaseng/widgets/gaseng_bottom_button.dart';
import 'package:gaseng/widgets/processing.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/sharehouse/sharehouse_response.dart';
import '../../repositories/sharehouse_repository.dart';
import '../../widgets/hash_tag.dart';

class SharehousePage extends StatefulWidget {
  const SharehousePage({Key? key}) : super(key: key);

  @override
  State<SharehousePage> createState() => _SharehousePageState();
}

class _SharehousePageState extends State<SharehousePage> {
  final DatabaseReference chatReference = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              "https://gaseng-default-rtdb.asia-southeast1.firebasedatabase.app")
      .ref();
  SharehouseRepository sharehouseRepository = SharehouseRepository();
  ScrapRepository scrapRepository = ScrapRepository();
  final ScrollController _scrollController = ScrollController();
  ChatRepository chatRepository = ChatRepository();
  SharehouseDetailResponse? sharehouse;
  int currentIndex = 0;
  late int id;
  bool isAuthor = false;
  bool isProcess = false;
  bool? isScrap = false;
  bool scrapProcessing = false;

  Future? mapFuture;
  Future? future;

  GoogleMapController? mapController;
  double? latitude;
  double? longitude;

  @override
  void initState() {
    id = Get.arguments;
    future = getSharehouse(id);
    super.initState();
  }

  Widget renderScrap() {
    if(scrapProcessing) {
      return const Center(child: CircularProgressIndicator(),);
    } else {
      return isScrap!
          ? const Icon(Icons.bookmark_outlined, color: Colors.orangeAccent,)
          : const Icon(Icons.bookmark_border);
    }
  }

  void scrapping() async {
    setState(() {
      scrapProcessing = true;
    });
    if (isScrap!) {
      await scrapRepository.delete(id);
      setState(() {
        isScrap = false;
      });
    } else {
      await scrapRepository.create(id);
      setState(() {
        isScrap = true;
      });
    }
    setState(() {
      scrapProcessing = false;
    });
  }

  Future<void> getLocationFromAddress() async {
    try {
      List<Location> locations = await locationFromAddress(sharehouse!.address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        latitude = location.latitude;
        longitude = location.longitude;

        if (mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newLatLng(LatLng(latitude!, longitude!)),
          );
        }
      } else {
        print('주소를 찾을 수 없습니다.');
      }
    } catch (e) {
      print('오류: $e');
    }
  }

  getSharehouse(int id) async {
    sharehouse = await sharehouseRepository.get(id);
    bool? state = await scrapRepository.isScrap(id);
    await getLocationFromAddress();
    await brainAuthor();
    setState(() {
      isScrap = state;
    });
  }

  matching() async {
    setState(() {
      isProcess = true;
    });
    bool state = await isReject();
    if (state) {
      dynamic response = await chatRepository.create(id);
      if (response['data'] != null) {
        ChatRoomCreateResponse chatResponse =
            ChatRoomCreateResponse.fromJson(response['data']);
        chatReference
            .child("chat")
            .child(chatResponse.chatRoomId.toString())
            .set({});
        Get.toNamed('/chat/room', arguments: [
          chatResponse.chatRoomId,
          chatResponse.senderId,
          chatResponse.receiverId
        ]);
      } else {
        kShowToast(response['message']);
      }
    }
    setState(() {
      isProcess = false;
    });
  }

  brainAuthor() async {
    String? loginMemId = await SessionManager.getMemId();
    String memId = sharehouse!.memId.toString();
    if (loginMemId == memId) {
      setState(() {
        isAuthor = true;
      });
    }
  }

  Future<bool> isReject() async {
    String? status = await SessionManager.getStatus();
    if (status == '거절') {
      kShowToast("KYC가 거절된 회원은 매칭신청을 할 수 없습니다.");
      return false;
    } else if (status == '대기') {
      kShowToast("KYC 요청이 아직 대기중입니다. 관리자가 승인할 때까지 기다려주세요.");
      return false;
    } else if (status == '노멀') {
      kShowToast("KYC 인증 이력이 없습니다. KYC를 등록해주세요.");
      return false;
    }
    return true;
  }

  Widget renderButton() {
    if (isAuthor) {
      return const SizedBox();
    } else {
      return Column(
        children: [
          Spacer(),
          GestureDetector(
            onTap: matching,
            child: GasengBottomButton(
              text: '매칭 신청',
              color: primary,
            ),
          ),
        ],
      );
    }
  }

  Widget buildIndicator(int currentIndex, int itemIndex) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == itemIndex ? Colors.black : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '쉐어하우스',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        actions: [
          GestureDetector(
            onTap: scrapping,
            child: renderScrap(),
          ),
          SizedBox(width: 16.0),
        ],
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (sharehouse == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider(
                            items: sharehouse!.images.map((imagePath) {
                              return CachedNetworkImage(
                                width: double.infinity,
                                imageUrl: imagePath,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              reverse: false,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              sharehouse!.images.length,
                              (index) => buildIndicator(index, currentIndex),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sharehouse!.title,
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            sharehouse!.address,
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            sharehouse!.description,
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '입주자',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: gray12,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Text(sharehouse!.name,
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 12.0),
                          Wrap(
                            runSpacing: 8.0,
                            children: [
                              HashTag(
                                  text: ChecklistEnum.getCigarette(
                                      sharehouse!.cigarette)),
                              HashTag(
                                  text:
                                      ChecklistEnum.getType(sharehouse!.type)),
                              HashTag(text: sharehouse!.mbti),
                              HashTag(text: "자는 시간 : ${sharehouse!.sleepTime}"),
                              HashTag(
                                  text: ChecklistEnum.getHabit(
                                      sharehouse!.habit)),
                              HashTag(text: sharehouse!.place),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '지도',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: gray12),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "${sharehouse!.address} 부근",
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: gray12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    if (latitude != null && longitude != null)
                      Container(
                        height: 300,
                        child: GoogleMap(
                          onMapCreated: (controller) {
                            mapController = controller;
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(latitude!, longitude!),
                            zoom: 15.0,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 100.0,
                    ),
                  ],
                ),
              ),
              renderButton(),
              Processing(isProcess: isProcess),
            ],
          );
        },
      ),
    );
  }
}
