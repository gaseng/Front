import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/constants/constant.dart';

import '../../models/sharehouse/sharehouse_response.dart';
import '../../repositories/sharehouse_repository.dart';
import '../../widgets/hash_tag.dart';

class SharehousePage extends StatefulWidget {
  const SharehousePage({Key? key}) : super(key: key);

  @override
  State<SharehousePage> createState() => _SharehousePageState();
}

class _SharehousePageState extends State<SharehousePage> {
  SharehouseRepository sharehouseRepository = SharehouseRepository();
  SharehouseResponse? sharehouse;
  int currentIndex = 0;
  Future? future;

  @override
  void initState() {
    future = getSharehouse();
    super.initState();
  }

  getSharehouse() async {
    sharehouse = await sharehouseRepository.get(47);

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
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (sharehouse == null) {
            return const Center(child: CircularProgressIndicator(),);
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider(
                        items: sharehouse!.images.map((imagePath) {
                          return Container(
                            height: 220.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(imagePath)
                                )
                            ),
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
                        )
                    ),
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
                        style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        sharehouse!.address,
                        style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 16.0,
                            backgroundColor: gray06,
                          ),
                          SizedBox(width: 8.0),
                          Text('백만송이 장미',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Wrap(
                        children: [
                          HashTag(text: '비흡연자'),
                          HashTag(text: '코골이 약간'),
                          HashTag(text: '자는 시간 : 11 AM'),
                          HashTag(text: '소극적'),
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
                Container(
                  width: double.infinity,
                  height: 200.h,
                  color: gray04,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
