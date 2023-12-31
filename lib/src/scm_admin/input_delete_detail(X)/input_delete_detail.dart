import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';
import 'package:hnde_pda/src/scm_admin/input_delete_detail(X)/input_delete_detail_controller.dart';

class ScmDeleteDetail extends StatefulWidget {
  ScmDeleteDetail({
    super.key,
    required this.trNm,
  });
  String trNm = '';
  @override
  State<ScmDeleteDetail> createState() => _ScmDeleteDetailState();
}

class _ScmDeleteDetailState extends State<ScmDeleteDetail> {
//   var focusNode = FocusNode(onKey: (node, event) {
//     if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
//         // Do something
//         // Next 2 line needed If you don't want to update the text field with new line.
//         // node.unfocus();
//         // return true;
//     }
//     return false;

// });

  final ScmDeleteDetailController _controller = ScmDeleteDetailController();

  var focusNodes = FocusNode();
  var focusNodes2 = FocusNode();
  String testStd = '';

  bool outTap = false;

  TextInputType inputType = TextInputType.none;

  @override
  void initState() {
    setInputType(false);
    focusNodes2.addListener(() {
      print(focusNodes2.hasFocus);
      focusNodes2.hasFocus == false
          ? FocusScope.of(context).requestFocus(focusNodes)
          : '';
    });

    super.initState();
  }

  TextInputType getInputType() {
    print(inputType);
    return inputType;
  }

  Future<void> setInputType(bool bo) async {
    inputType = bo == true ? TextInputType.text : TextInputType.none;
    print(inputType);
  }

  Future<void> setFocus() async {
    FocusScope.of(context).requestFocus(focusNodes);
  }

  Future<void> pageUpdate() async {
    setState(() {});
  }

  TextEditingController txtCon = TextEditingController();
  TextEditingController txtCon2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.7,
          title: Text(
            'SCM 입고삭제',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Center(
                      child: Text(
                        '거래처',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          widget.trNm,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(flex: 1, child: Container())
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Text(
                      '출고일자',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Obx(() => Text(
                            "${_controller.model.selectedDateRange.start.toLocal().toString().split(' ')[0]} ~ ${_controller.model.selectedDateRange.end.toLocal().toString().split(' ')[0]}",
                            style: const TextStyle(fontSize: 17),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () async {
                          await _controller.selectDate(context);
                          _controller.outputdata();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                          size: 28,
                        ))
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     await _viewModel
                    //         .selectDateRange(context);
                    //   },
                    //   child: const Icon(
                    //     Icons.calendar_today_rounded,
                    //     size: 27,
                    //   ),
                    // ),
                    ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Container(
                height: 1,
                color: Colors.grey.shade800,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Obx(
                    () => ListView.builder(
                      itemCount: _controller.model.deletedata.length,
                      itemBuilder: (context, index) {
                        //final selectedItem = _controller.outputlist[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            height: 120, // 아이템 높이 지정
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            child: Container(
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                15))),
                                            child: const Center(
                                              child: Text(
                                                '입고번호',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                            //color: Colors.grey.withOpacity(0.3),
                                            child: Center(
                                              child: Text(
                                                '${_controller.model.deletedata[index]["RCV_NB"]}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                '품번',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            //color: Colors.grey.withOpacity(0.3),
                                            child: Center(
                                              child: Text(
                                                '${_controller.model.deletedata[index]["ITEM_CD"]}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: Colors.grey.withOpacity(0.3),
                                            child: const Center(
                                              child: Text(
                                                '품명',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            //color: Colors.grey.withOpacity(0.3),
                                            child: Center(
                                              child: Text(
                                                '${_controller.model.deletedata[index]["ITEM_NM"]}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                15))),
                                            child: const Center(
                                              child: Text(
                                                '출고수량',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            //color: Colors.grey.withOpacity(0.3),
                                            child: Center(
                                              child: Text(
                                                '${_controller.model.deletedata[index]["PSU_QT"]}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: Colors.grey.withOpacity(0.3),
                                            child: const Center(
                                              child: Text(
                                                '입고수량',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            //color: Colors.grey.withOpacity(0.3),
                                            child: Center(
                                              child: Text(
                                                '${_controller.model.deletedata[index]["RCV_QT"]}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )),
            ),
          ],
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.grey,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.border_color, color: Colors.white),
              SizedBox(
                width: 3,
              ),
              Text(
                ' 입고삭제',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
