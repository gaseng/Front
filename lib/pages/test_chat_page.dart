import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gaseng/constants/constant.dart';
import 'package:gaseng/widgets/gaseng_text_field.dart';

class Message {
  String sender;
  String message;
  Message({required this.sender, required this.message});
}

class TestChatPage extends StatefulWidget {
  const TestChatPage({Key? key}) : super(key: key);

  @override
  State<TestChatPage> createState() => _TestChatPageState();
}

class _TestChatPageState extends State<TestChatPage> {
  final databaseReference = FirebaseDatabase.instance.ref();
  TextEditingController controller = TextEditingController();

  List<Message> messages = [];
  String who = "나";

  @override
  void initState() {
    receiveMessages();
    super.initState();
  }

  Future<void> sendMessage(String sender, String message) async {
    await databaseReference.child('chat').child("1").push().set({
      'sender': who,
      'message': message,
    });
  }

  void receiveMessages() {
    databaseReference.child('chat').child("1").onChildAdded.listen((event) {
      dynamic data = event.snapshot.value;
      String sender = data!['sender'];
      String message = data!['message'];
      setState(() {
        messages.add(Message(sender: sender, message: message));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...messages.map((m) {
            return MessageUI(sender: m.sender, message: m.message);
          }).toList(),
          Row(
            children: [
              TextButton(onPressed: () {
                who = "나";
              }, child: Text('나로 설정')),
              TextButton(onPressed: () {
                who = "상대방";
              }, child: Text('상대방으로 설정')),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: GasengTextField(
                  labelText: '',
                  controller: controller,
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () async {
                    await sendMessage('나', controller.text);
                    setState(() {
                      controller.text = "";
                    });
                  },
                  child: Text('보내기'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MessageUI extends StatelessWidget {
  MessageUI({required this.sender, required this.message});
  final sender;
  final message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Text('$sender : $message'),
      decoration: BoxDecoration(
          color: sender == "나" ? Colors.tealAccent : gray06,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}
