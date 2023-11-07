import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/scm_admin/input_register/input_register_controller.dart';
import 'package:hnde_pda/src/scm_admin/input_register_detail/input_register_detail_controller.dart';

class ScmRegisterDetail extends StatefulWidget {
  String detailNumber = '';
  String trNm = '';
  ScmRegisterController controller1;
  int index;

  ScmRegisterDetail(
      {super.key,
      required this.detailNumber,
      required this.trNm,
      required this.controller1,
      required this.index});

  @override
  State<ScmRegisterDetail> createState() => _ScmRegisterDetailState();
}

class _ScmRegisterDetailState extends State<ScmRegisterDetail> {
  final ScmRegisterDetailController _controller = ScmRegisterDetailController();

  TextEditingController txtCon = TextEditingController();

  bool outTap = false;

  void pageUpdate() {
    setState(() {});
  }

  @override
  void initState() {
    _controller.boxData(widget.detailNumber, widget.controller1,
        widget.controller1.model.selectData1[widget.index]["PSU_SQ"]);
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
                          controller: _controller.model.txtCon,
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
                            await _controller.checkNb(widget.detailNumber);
                            await _controller.barcodecheck(
                                context,
                                widget.controller1,
                                widget.detailNumber,
                                widget.index);

                            _controller.model.txtCon.text = '';
                            _controller.model.txtCon.clear();
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
                                  _controller.barcodecheck(
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
                                  _controller.barcodecheck(
                                      context,
                                      widget.controller1,
                                      widget.detailNumber,
                                      widget.index);
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
                                    _controller.getColor(
                                        index, widget.controller1),
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
                                    _controller.getColor(
                                        index, widget.controller1),
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
                                    _controller.getColor(
                                        index, widget.controller1),
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
            //await _controller.clearSpec(widget.detailNumber, widget.index,
            //  widget.controller1, _controller.getboxSq());
            _controller.plus();
            widget.controller1.model.sum[widget.index] =
                _controller.model.sum.toString();
            _controller.setSelectChk();
            widget.controller1.model.datavalue[widget.index] =
                _controller.getselect();

            _controller.checkcount(
                widget.controller1.model.rsData[widget.index]["PSU_NB"],
                widget.controller1.model.rsData[widget.index]["PSU_SQ"],
                widget.controller1);

            Get.back();
            widget.controller1.updateStates();
            //setState(() {});
          },
        ),
      ),
    );
  }
}
