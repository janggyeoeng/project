import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/scm_admin/return_item/return_item_register_controller.dart';
import 'package:hnde_pda/src/scm_admin/return_item_detail/return_item_register_detail.dart';

class ReturnRegister extends StatefulWidget {
  const ReturnRegister({Key? key}) : super(key: key);

  @override
  State<ReturnRegister> createState() => _ReturnRegisterState();
}

class _ReturnRegisterState extends State<ReturnRegister> {
//   var focusNode = FocusNode(onKey: (node, event) {
//     if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
//         // Do something
//         // Next 2 line needed If you don't want to update the text field with new line.
//         // node.unfocus();
//         // return true;
//     }
//     return false;

// });

  final ReturnRegisterController _controller = ReturnRegisterController();

  var focusNodes = FocusNode();
  var focusNodes2 = FocusNode();
  String testStd = '';

  bool outTap = false;

  TextInputType inputType = TextInputType.none;

  @override
  void initState() {
    pageUpdate();
    _controller.setStates(pageUpdate);
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
            'SCM 반품등록',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            //RawKeyboardListener(
            // focusNode: focusNodes,
            // onKey: (e){
            //           if(e.isKeyPressed(LogicalKeyboardKey.enter)){
            //             print('enter : ${e}');
            //           }
            // },
            Row(
              //child:
              children: [
                Expanded(
                  flex: 2,
                  child: Stack(children: [
                    Center(
                      child: Container(
                        //width: 50,
                        child: TextField(
                          focusNode: focusNodes,
                          controller: txtCon,
                          autofocus: true,
                          cursorColor: Colors.transparent,
                          cursorWidth: 0,
                          keyboardType: TextInputType.none, //getInputType(),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          onSubmitted: (value) async {
                            //await _controller.printf(value);
                            print(value);
                            txtCon.text = '';
                          },
                          onChanged: (value) {
                            //print('aaa');
                            //txtCon.text = '';
                          },
                          //  onTapOutside: (value){
                          //    print('ddd');
                          //    FocusScope.of(context).unfocus();
                          //    FocusScope.of(context).requestFocus(focusNodes);
                          //  },
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
                                focusNode: focusNodes2,
                                cursorColor: Colors.transparent,
                                cursorWidth: 0,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                onFieldSubmitted: (value) async {
                                  outTap = false;
                                  await _controller.returnItem(context, value);
                                  await _controller.setController();
                                  setFocus();
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
                                child: const SizedBox(
                                  width: 20,
                                  height: 20,
                                  //color: Colors.green,
                                  child: Icon(
                                    Icons.keyboard,
                                    color: Colors.blue,
                                  ),
                                ),
                                onTap: () async {
                                  print('클릭');
                                  //FocusScope.of(context).unfocus();
                                  //await setInputType(true);
                                  outTap = true;
                                  FocusScope.of(context)
                                      .requestFocus(focusNodes2);
                                  //print(this.inputType);
                                  //await pageUpdate();

                                  //await setFocus();
                                  //FocusScope.of(context).requestFocus(focusNodes);
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
              // ),
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
                child: ListView.builder(
                  itemCount: _controller.model.returnData.length,
                  itemBuilder: (context, index) {
                    //final selectedItem = _controller.outputlist[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ReturnRegisterDetail(
                            detailNumber: _controller.model.returnData[index]
                                ["PSU_NB"],
                            trNm: _controller.model.returnData[index]["TR_NM"],
                            controller1: _controller,
                            index: index));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        height: 100, // 아이템 높이 지정
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
                                            color: _controller.getColor(index),
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
                                      flex: 2,
                                      child: Container(
                                        //color: Colors.grey.withOpacity(0.3),
                                        child: Center(
                                          child: Text(
                                            '${_controller.model.returnData[index]["ITEM_CD"]}',
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
                                            '품명',
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
                                            '${_controller.model.returnData[index]["ITEM_NM"]}',
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
                                            color: _controller.getColor(index),
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
                                            '${_controller.model.returnData[index]["UNIT_DC"]}',
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
                                            '반품수량',
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
                  ' 반품등록',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ],
            ),
            onTap: () {
              _controller.returnRegist(context, _controller.getPsuDt());
              print("a:${_controller.getPsuDt()}");
            },
          ),
        ),
      ),
    );
  }
}
