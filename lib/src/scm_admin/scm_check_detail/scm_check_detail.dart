import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/scm_admin/scm_check/scm_check_controller.dart';

import 'package:hnde_pda/src/scm_admin/scm_check_detail/scm_check_detail_controller.dart';

class ScmCheckDetail extends StatefulWidget {
  String detailNumber;
  String trNm = '';
  ScmCheckController controller1;
  int index;

  ScmCheckDetail(
      {super.key,
      required this.detailNumber,
      required this.trNm,
      required this.controller1,
      required this.index});

  @override
  State<ScmCheckDetail> createState() => _ScmCheckDetailState();
}

class _ScmCheckDetailState extends State<ScmCheckDetail> {
  final ScmCheckDetailController _controller = ScmCheckDetailController();

  TextEditingController txtCon = TextEditingController();

  bool outTap = false;

  void pageUpdate() {
    setState(() {});
  }

  @override
  void initState() {
    _controller.boxData(widget.detailNumber, widget.controller1, widget.index);
    // print("a:${widget.controller1.model.datavalue}");
    super.initState();
    _controller.textFocusListner(context, pageUpdate);
    _controller.barcodeFocusListner(context);
    // _controller.getTextNode().addListener(() {
    //   if (_controller.getTextNode().hasFocus == false) {
    //     FocusScope.of(context).requestFocus(_controller.getBarcodeNode());
    //   }
    // });
  }

  FocusNode aafocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '발행수량 정보',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Stack(children: [
                    Center(
                      child: Container(
                        //width: 50,
                        child: TextField(
                          focusNode: _controller.getBcNode(),
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
                            //await _controller.scanBarcode(value);

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
                                //controller: _controller.gettxtCon(),
                                //focusNode: _controller.getTextNode(),
                                cursorColor: Colors.transparent,
                                cursorWidth: 1,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                onFieldSubmitted: (value) async {
                                  print(value);
                                  //await _controller.scanBarcode(value);
                                  await _controller.check(
                                      context,
                                      widget.controller1,
                                      widget.detailNumber,
                                      widget.index);

                                  outTap = false;
                                  _controller.setFocus(context);
                                  setState(() {});
                                },
                              ),
                              TextFormField(
                                controller: _controller.gettxtCon(),
                                focusNode: _controller.getTxtNode(),
                                // readOnly: true,
                                // cursorColor: Colors.transparent,
                                // cursorWidth: 0,
                                decoration: const InputDecoration(
                                    //border: InputBorder.none
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey))),
                                onFieldSubmitted: (value) async {
                                  _controller.checkNb(widget.detailNumber);
                                  _controller.check(context, widget.controller1,
                                      widget.detailNumber, widget.index);
                                  //_controller.plus();
                                  outTap = false;
                                  _controller.setFocus(context);
                                  setState(() {});
                                },
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
                                      .requestFocus(_controller.getTxtNode());

                                  setState(() {});
                                },
                              ))
                        ],
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Text(
                      '출고번호',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Text(
                      widget.detailNumber,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Text(
                      '거래처',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Text(
                      widget.trNm,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Expanded(
              child: Obx(
                () {
                  final detailData = _controller.model.detailData.value;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: detailData.length,
                    itemBuilder: (context, index) {
                      final selectedItem = detailData[index];
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(5, 15, 5, 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Colors.black.withOpacity(0.7))),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _controller.detailcontainar(
                                    '품번',
                                    GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    _controller.getColor(index),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: _controller.detailcontainar(
                                    '${selectedItem["ITEM_CD"]}',
                                    GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _controller.detailcontainar(
                                    '박스번호',
                                    GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    _controller.getColor(index),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _controller.detailcontainar(
                                    '${selectedItem["BOX_NO"]}',
                                    GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    Colors.white,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _controller.detailcontainar(
                                    '포장단위수량',
                                    GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    _controller.getColor(index),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _controller.detailcontainar(
                                    '${selectedItem["PACK_QT"]}',
                                    GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        height: 60,
        child: GestureDetector(
          child: Container(
            color: Colors.grey,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.border_color, color: Colors.white),
                SizedBox(
                  width: 3,
                ),
                Text(
                  '수량등록',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ],
            ),
          ),
          onTap: () async {
            // widget.controller1.model.datavalue[widget.index] = true;
            _controller.plus();
            await _controller.setSelectChk();

            widget.controller1.model.datavalue[widget.index] =
                _controller.getselect();
            // print('AAAA:${_controller.model.boxdata}');
            widget.controller1.setKeyboardClick(false);
            widget.controller1.model.sum[widget.index] =
                _controller.model.sum.toString();
            // print('abc:${widget.controller1.model.sum[widget.index]}');

            widget.controller1.model.barcodedata =
                _controller.model.barcodedata;

            widget.controller1.model
                .updatedata(widget.detailNumber, widget.index + 1);
            _controller.checkcount(
                widget.controller1.model.detailData[widget.index]["PSU_NB"],
                widget.controller1.model.detailData[widget.index]["PSU_SQ"]);
            // print(_controller.model.barcodedata);
            // print('a:${_controller.model.sum}');
            Get.back();
            //_controller.updatedata(widget.detailNumber, widget.index);
            // _controller.saveEnd(widget.detailNumber);
            //setState(() {});
          },
        ),
      ),
    );
  }
}
