import 'package:flutter/material.dart';
import 'package:gaseng/models/login/checklist_request.dart';
import 'package:gaseng/repositories/checklist_repository.dart';
import 'package:gaseng/widgets/gaseng_text_field.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';
import '../../models/login/checklist_response.dart';
import '../../widgets/gaseng_general_button.dart';

class CheckListModifyPage extends StatefulWidget {
  @override
  State<CheckListModifyPage> createState() => _CheckListModifyPageState();
}

class _CheckListModifyPageState extends State<CheckListModifyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController callPlaceController = TextEditingController();
  ChecklistRepository checklistRepository = ChecklistRepository();
  ChecklistResponse? response;
  Future? future;

  TimeOfDay initialTime = TimeOfDay.now();
  int cigarette = 0;
  int sleepingType = 0;
  int type = 0;
  List<String> mbtiTypes = [
    "INTJ",
    "ENTP",
    "INFP",
    "ISTJ",
    "ENFJ",
    "ESTP",
    "INFJ",
    "ISFJ",
    "ENFP",
    "ESTJ",
    "ISFP",
    "ESFP",
    "ISTP",
    "ESFJ",
    "ENTJ",
    "INTP"
  ];
  String mbti = "INTJ";

  String? validateCall(String? value) {
    if (value!.isEmpty) {
      return '입력하세요.';
    }
  }

  submit() async {
    if (_formKey.currentState!.validate()) {
      DateTime now = DateTime.now();
      DateTime dateTime = DateTime(
          now.year, now.month, now.day, initialTime.hour, initialTime.minute);
      String formattedDateTime = dateTime.toLocal().toIso8601String();

      ChecklistRequest request = ChecklistRequest(
        chkSleepingHabit: sleepingType.toString(),
        chkCigarette: cigarette.toString(),
        chkSleepTime: formattedDateTime,
        chkMbti: mbti,
        chkCallPlace: callPlaceController.text,
        chkType: type.toString(),
      );

      int? code = await checklistRepository.update(request);
      if (code != null && code == 200) {
        Get.back();
      }
    }
  }

  toggleCigarette(int mode) {
    print(initialTime);
    setState(() {
      cigarette = mode;
    });
  }

  toggleSleep(int mode) {
    setState(() {
      sleepingType = mode;
    });
  }

  toggleType(int mode) {
    setState(() {
      type = mode;
    });
  }
  
  getChecklist() async {
    response = await checklistRepository.get();
    if (response != null) {
      cigarette = response!.chkCigarette == "SMOKER" ? 0 : 1;
      sleepingType = response!.chkSleepingHabit == "NONE" ? 0 : response!.chkSleepingHabit == "MILD" ? 1 : 2;
      type = response!.chkType == "ACTIVE" ? 0 : 1;
      callPlaceController.text = response!.chkCallPlace;
      print(response!.chkCallPlace);
      mbti = response!.chkMbti;

      List<String> timeParts = response!.chkSleepTime.split(":");
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);
      initialTime = TimeOfDay(hour: hour, minute: minute);
    }
  }

  @override
  void initState() {
    future = getChecklist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '체크리스트 작성',
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
          if (response == null) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '흡연',
                        style: TextStyle(color: gray08),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => toggleCigarette(0),
                              child: GasengGeneralButton(
                                text: '비흡연자',
                                color: cigarette == 0 ? primary : Colors.white,
                                textColor:
                                cigarette == 0 ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => toggleCigarette(1),
                              child: GasengGeneralButton(
                                text: '흡연자',
                                color: cigarette == 1 ? primary : Colors.white,
                                textColor:
                                cigarette == 1 ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 34),
                      Text(
                        '잠버릇',
                        style: TextStyle(color: gray08),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => toggleSleep(0),
                              child: GasengGeneralButton(
                                text: '코골이 없음',
                                color: sleepingType == 0 ? primary : Colors.white,
                                textColor:
                                sleepingType == 0 ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => toggleSleep(1),
                              child: GasengGeneralButton(
                                text: '코골이 약간',
                                color: sleepingType == 1 ? primary : Colors.white,
                                textColor:
                                sleepingType == 1 ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => toggleSleep(2),
                              child: GasengGeneralButton(
                                text: '코골이 심함',
                                color: sleepingType == 2 ? primary : Colors.white,
                                textColor:
                                sleepingType == 2 ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 34),
                      Text(
                        '소등 시간',
                        style: TextStyle(color: gray08),
                      ),
                      SizedBox(height: 12),
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? timeOfDay = await showTimePicker(
                              context: context, initialTime: initialTime);
                          if (timeOfDay != null) {
                            setState(() {
                              initialTime = timeOfDay;
                            });
                          }
                        },
                        child: Container(
                          child: Text('${initialTime.hour}:${initialTime.minute}',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.w400)),
                          padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                          decoration: BoxDecoration(
                              color: gray04,
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        ),
                      ),
                      SizedBox(height: 34),
                      Text(
                        '생활 습관',
                        style: TextStyle(color: gray08),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => toggleType(0),
                              child: GasengGeneralButton(
                                text: '활동적',
                                color: type == 0 ? primary : Colors.white,
                                textColor: type == 0 ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => toggleType(1),
                              child: GasengGeneralButton(
                                text: '소극적',
                                color: type == 1 ? primary : Colors.white,
                                textColor: type == 1 ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 34),
                      Text(
                        'MBTI',
                        style: TextStyle(color: gray08),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        child: DropdownButton(
                          value: mbti,
                          items: mbtiTypes.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              mbti = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 34),
                      Text(
                        '주로 전화하는 곳',
                        style: TextStyle(color: gray08),
                      ),
                      SizedBox(height: 12),
                      GasengTextField(
                        labelText: '입력란',
                        controller: callPlaceController,
                        validator: validateCall,
                      ),
                      SizedBox(height: 40.0),
                      GestureDetector(
                        onTap: submit,
                        child: GasengGeneralButton(
                          text: '확인',
                          color: primary,
                          textColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        }
      ),
    );
  }
}
