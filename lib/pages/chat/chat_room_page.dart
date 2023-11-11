import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaseng/auth/SessionManager.dart';
import 'package:gaseng/repositories/chat_repository.dart';
import 'package:gaseng/repositories/kyc_repository.dart';
import 'package:gaseng/widgets/processing.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';
import '../../models/kyc/customer.dart';
import '../../widgets/message.dart';
import '../../widgets/system_chat.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final DatabaseReference reference = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              "https://gaseng-default-rtdb.asia-southeast1.firebasedatabase.app")
      .ref();
  late DatabaseReference chatReference;
  TextEditingController textController = TextEditingController();
  ChatRepository chatRepository = ChatRepository();
  KycRepository kycRepository = KycRepository();
  late int chatRoomId;
  late int memId;
  late String nickname;
  List<Message> messageList = [];
  bool isProcess = false;

  @override
  void initState() {
    List<int> list = Get.arguments;
    chatRoomId = list[0];
    if (list.length == 3) {
      reference.child("chat").child(chatRoomId.toString()).set({
        "mem1": list[1],
        "mem2": list[2],
        "kyc": 0
      });
    }

    chatReference = reference.child("chat").child(chatRoomId.toString());
    getInfo();
    super.initState();
  }

  void require() async {
    Get.back();

    setState(() {
      isProcess = true;
    });
    String key = DateTime.now().millisecondsSinceEpoch.toString();
    DatabaseReference newRef = chatReference.child(key);

    final _snapshot = await chatReference.get();
    Map<dynamic, dynamic> _value = _snapshot.value as Map<dynamic, dynamic>;
    int kyc = int.parse(_value['kyc'].toString());
    if (_snapshot.exists) {
      if (kyc == 0) {
        await newRef.set({
          'id': memId,
          'name': 'system',
          'message': '[시스템 메시지]\nKYC를 요청했습니다.\n요청에 응하면 KYC요청 버튼을 눌러주세요.',
          'timestamp': ServerValue.timestamp,
        });
        chatReference.update({
          "kyc": memId,
        });
        chatRepository.updateMessage(chatRoomId, '[시스템 메시지]\nKYC를 요청했습니다.\n요청에 응하면 KYC요청 버튼을 눌러주세요.');

      } else if (kyc == memId) {
        kShowToast("이미 요청하셨습니다.");
      } else {

        int mem1 = int.parse(_value['mem1'].toString());
        int mem2 = int.parse(_value['mem2'].toString());

        Customer c1 = await kycRepository.getData(mem1);
        Customer c2 = await kycRepository.getData(mem2);

        await newRef.set({
          'id': mem1,
          'name': 'system',
          'message': '[KYC DATA]\nname: ${c1.name}\nbirth: ${c1.birth}\naddress: ${c1.addr}\njob: ${c1.job}',
          'timestamp': ServerValue.timestamp,
        });

        String k = DateTime.now().millisecondsSinceEpoch.toString();
        DatabaseReference nr = chatReference.child(k);

        await nr.set({
          'id': mem2,
          'name': 'system',
          'message': '[KYC DATA]\nname: ${c2.name}\nbirth: ${c2.birth}\naddress: ${c2.addr}\njob: ${c2.job}',
          'timestamp': ServerValue.timestamp,
        });
        await chatReference.update({"kyc": 0});

        chatRepository.updateMessage(chatRoomId, '[KYC DATA]\nname: ${c2.name}\nbirth: ${c2.birth}\naddress: ${c2.addr}\njob: ${c2.job}');

      }
    } else {
      print("없음!");
    }

    setState(() {
      isProcess = false;
    });


  }

  void submit() async {
    // firebase realtime database
    String message = textController.text;
    setState(() {
      textController.text = "";
    });

    String key = DateTime.now().millisecondsSinceEpoch.toString();
    DatabaseReference newRef = chatReference.child(key);

    await newRef.set({
      'id': memId,
      'name': nickname,
      'message': message,
      'timestamp': ServerValue.timestamp,
    });

    // mysql last message
    chatRepository.updateMessage(chatRoomId, message);
  }

  void getInfo() async {
    String? id = await SessionManager.getMemId();
    String? nick = await SessionManager.getNickname();
    memId = int.parse(id!);
    nickname = nick!;
  }

  void requestKyc(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            'KYC 요청',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          contentPadding: EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('상대방에게 KYC를 요청하시겠습니까?'),
                    SizedBox(height: 12.0),
                    Text(
                      '[주의사항]\n1. 상대방에게 KYC 요청이 메시지로 전달됩니다.\n2. 요청을 승낙하면 자신의 KYC가 상대방에게 전달됩니다.\n3. 충분한 대화를 통해 상대방을 신뢰할 수 있는 경우에만 요청하시기 바랍니다.',
                      style: TextStyle(color: gray08, fontSize: 12.0),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: gray06,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40.0))),
                        child: Center(
                            child: Text(
                          '취소',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: require,
                      child: Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: const Color(0xFF99A9FF),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40.0))),
                        child: Center(
                            child: Text(
                          '요청',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '채팅방',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                requestKyc(context);
              },
              child: Text(
                'KYC 요청',
                style: TextStyle(color: Colors.blue, fontSize: 12.0),
              ),
            ),
          ),
          SizedBox(
            width: 16.0,
          )
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream:
                reference.child("chat").child(chatRoomId.toString()).onValue,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  (snapshot.data! as DatabaseEvent).snapshot.value != null) {
                final myMessages = Map<dynamic, dynamic>.from(
                    (snapshot.data! as DatabaseEvent).snapshot.value
                        as Map<dynamic, dynamic>);

                messageList = [];

                myMessages.forEach((key, value) {
                  if (key != "kyc" && key != "mem1" && key != "mem2") {
                    final currentMessage = Map<String, dynamic>.from(value);
                    int id = currentMessage['id'];

                    messageList.add(
                        Message(isMe: memId == id, nick: currentMessage['name'], message: currentMessage['message'], timestamp: currentMessage['timestamp'])
                    );
                  }
                });

                messageList.sort((a, b) {
                  final int timestampA = a.timestamp;
                  final int timestampB = b.timestamp;

                  return timestampA.compareTo(timestampB);
                });

                return Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        children: messageList.map((message) {
                          return message;
                        }).toList()
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration:
                            BoxDecoration(border: Border.all(color: gray04)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: textController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 10,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent)),
                                ),
                              ),
                            ),
                            FilledButton(
                              onPressed: submit,
                              style: FilledButton.styleFrom(
                                backgroundColor: primary,
                              ),
                              child: Text(
                                '전송',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Center(child: Text('채팅이 없습니다.'))
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration:
                        BoxDecoration(border: Border.all(color: gray04)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: textController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 10,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.transparent)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.transparent)),
                                ),
                              ),
                            ),
                            FilledButton(
                              onPressed: submit,
                              style: FilledButton.styleFrom(
                                backgroundColor: primary,
                              ),
                              child: Text(
                                '전송',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          Processing(isProcess: isProcess)
        ],
      ),
    );
  }
}
