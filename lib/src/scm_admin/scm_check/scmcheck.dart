import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/scm_admin/scm_check/scm_check_controller.dart';
import 'package:get/get.dart';

import 'package:hnde_pda/src/scm_admin/scm_check_detail/scm_check_detail.dart';

class ScmCheck extends StatefulWidget {
  const ScmCheck({Key? key}) : super(key: key);

  @override
  State<ScmCheck> createState() => _ScmCheckState();
}

class _ScmCheckState extends State<ScmCheck> {
//   var focusNode = FocusNode(onKey: (node, event) {
//     if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
//         // Do something
//         // Next 2 line needed If you don't want to update the text field with new line.
//         // node.unfocus();
//         // return true;
//     }
//     return false;

// });

  final ScmCheckController _controller = ScmCheckController();
  String detailNumber = '';
  String testStd = '';
  String psuNb = '';

  bool outTap = false;

  TextEditingController txtCon = TextEditingController();
  TextEditingController txtCon2 = TextEditingController();

  FocusNode testNode = FocusNode();

  void pageUpdate() {
    setState(() {});
  }

  @override
  void initState() {
    //setInputType(false);
    //print('asasas ${txtCon.value}');
    print("a:${_controller.model.datavalue}");
    _controller.pageLoad();
    _controller.textFocusListner(context, pageUpdate);
    _controller.barcodeFocusListner(context);
    // focusNodes2.addListener(() {
    //   print(focusNodes2.hasFocus);
    //   focusNodes2.hasFocus == false ? FocusScope.of(context).requestFocus(focusNodes) : '';
    // });
    super.initState();
  }

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
            'SCM 수입검사',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            //RawKeyboardListener(
            // focusNode: testNode,
            //onKey: (e) async {
            //  if (e.isKeyPressed(LogicalKeyboardKey.enter)) {
            //print(
            //        'testStd : $testStd'); //.replaceAll('Shift', '').replaceAll('Left', '').replaceAll(' ', '')
            //   await _controller.scanBarcode(testStd
            //.replaceAll('Shift', '')
            //      .replaceAll('Left', '')
            //      .replaceAll(' ', ''));
            //  testStd = '';
            //  setState(() {});
            //} else {
            //   if (e.runtimeType.toString() == 'RawKeyDownEvent') {
            //      String key = e.logicalKey.keyLabel;
            //      setState(() {
            //        testStd += key;
            //      });
            //  }
            //}

            // // testStd += e.data.logicalKey.toString();
            // //   if(e.isKeyPressed(LogicalKeyboardKey.enter)){
            // //     print(testStd);
            // //   }
            //},
            Row(
              //child:
              //child:
              children: [
                Expanded(
                  flex: 2,
                  child: Stack(children: [
                    Center(
                      child: Container(
                        //width: 50,
                        child: TextField(
                          focusNode: _controller.getBarcodeNode(),
                          controller: txtCon,
                          autofocus: true,
                          cursorColor: Colors.transparent,
                          cursorWidth: 0,
                          keyboardType: TextInputType.none,
                          decoration: const InputDecoration(
                              //border: InputBorder.none
                              ),
                          onSubmitted: (value) {
                            print('saas $value');
                          },
                          onChanged: (value) async {
                            //print(txtCon.text);
                            await _controller.specCheck(value);
                            await _controller.scanBarcode(context, value);
                            await _controller.setController();

                            txtCon.text = '';
                            txtCon.clear();
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(7),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const Center(
                        child: Text(
                          '바코드',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                    flex: 7,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Stack(children: [
                              TextFormField(
                                controller: txtCon2,
                                focusNode: _controller.getTextNode(),
                                cursorColor: Colors.transparent,
                                cursorWidth: 0,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                onFieldSubmitted: (value) async {
                                  print(value);
                                  await _controller.specCheck(value);
                                  await _controller.scanBarcode(context, value);
                                  await _controller.setController();
                                  outTap = false;
                                  // _controller.setFocus(context);
                                  setState(() {});
                                },
                              ),
                              TextFormField(
                                //controller: txtCon2,
                                readOnly: true,
                                cursorColor: Colors.transparent,
                                cursorWidth: 0,
                                decoration: const InputDecoration(
                                    //border: InputBorder.none
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey))),
                              ),
                            ]),
                          ),
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  //color: Colors.green,
                                  child: Icon(Icons.keyboard,
                                      color: _controller
                                          .setKeyboardColor() //Colors.blue,
                                      ),
                                ),
                                onTap: () async {
                                  print('클릭');

                                  await _controller.setKeyboardClick(true);
                                  outTap = true;
                                  FocusScope.of(context)
                                      .requestFocus(_controller.getTextNode());

                                  setState(() {});
                                },
                              ))
                        ],
                      ),
                    )
                    // TextField(
                    //   //autofocus: true,
                    //   decoration: InputDecoration(hintText: '바코드를 입력하세요'),
                    //   onSubmitted: (value){
                    //       print(value);
                    //   },
                    //   onTapOutside: (Value){
                    //    // print('포커스아웃');

                    //     FocusScope.of(context).requestFocus(focusNodes);
                    //     FocusScope.of(context).unfocus();
                    //   },
                    // ),
                    ),
              ],
            ),
            // ),
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
                        '출고번호',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 7,
                    child: Row(children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          //'${_controller.model.detailData[0]["PSU_NB"]}',
                          _controller.getPsuNb(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(flex: 1, child: Container())
                    ])),
              ],
            ),
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
                    child: Row(children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          _controller.getTrNm(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(flex: 1, child: Container())
                    ])),
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
                    itemCount: _controller.model.detailData.length,
                    itemBuilder: (context, index) {
                      //final selectedItem = _controller.outputlist[index];
                      return GestureDetector(
                        onTap: () async {
                          await _controller.setKeyboardClick(true);
                          // _controller.model.datavalue = true;
                          // FocusManager.instance.primaryFocus?.unfocus();
                          //FocusScope.of(context).offset;

                          Get.to(() => ScmCheckDetail(
                              detailNumber: _controller.model.detailData[index]
                                  ["PSU_NB"],
                              trNm: _controller.model.detailData[index]
                                  ["TR_NM"],
                              controller1: _controller,
                              index: index
                              // updateState: pageUpdate,
                              ));
                          //await _controller.setKeyboardClick(false);
                          setState(() {});

                          //     ));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          height: 100, // 아이템 높이 지정
                          width: double.infinity,
                          decoration: BoxDecoration(
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
                                              color: _controller.getColor(
                                                  index),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15))),
                                          child: const Center(
                                            child: Text(
                                              '품번',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
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
                                              '${_controller.model.detailData[index]["ITEM_CD"]}',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                              textAlign: TextAlign.center,
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
                                          color: _controller.getColor(index),
                                          child: const Center(
                                            child: Text(
                                              '품명',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
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
                                              '${_controller.model.detailData[index]["ITEM_NM"]}',
                                              style:
                                                  const TextStyle(fontSize: 14),
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
                                              color: _controller.getColor(
                                                  index),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(15))),
                                          child: const Center(
                                            child: Text(
                                              '단위',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
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
                                              '${_controller.model.detailData[index]["UNIT_DC"]}',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          color: _controller.getColor(index),
                                          child: const Center(
                                            child: Text(
                                              '입고수량',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
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
                                              _controller.psuQt(index),
                                              style:
                                                  const TextStyle(fontSize: 14),
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
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey,
          height: 60,
          child: GestureDetector(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.border_color, color: Colors.white),
                SizedBox(
                  width: 3,
                ),
                Text(
                  ' 수입검사',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ],
            ),
            onTap: () async {
              await _controller.checkList(context);
              _controller.updateinfo(
                  _controller.getPsuNb(), _controller.getPsuSq());
              //await _controller.updatedata(
              // _controller.getPsuNb(), _controller.getPsuSq());
              //Get.back();

              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
