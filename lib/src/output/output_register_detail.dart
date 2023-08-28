import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/controller/output/register_detail_controller.dart';

class OutputRegisterDetail extends StatefulWidget {
  final String detailNumber;
  OutputRegisterDetail({required this.detailNumber});

  @override
  State<OutputRegisterDetail> createState() => _OutputRegisterDetailState();
}

class _OutputRegisterDetailState extends State<OutputRegisterDetail> {
  final OpRegisterDetailController _controller = OpRegisterDetailController();

  @override
  void initState() {
    _controller.pageLoad(widget.detailNumber);
    super.initState();
  }

  Widget _detailcontainar(String text, TextStyle style, int index) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - 317,
      // width: 99.7,
      decoration: BoxDecoration(
        color: _controller.selectColor(index),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(1),
          ),
        ],
      ),
      child: Center(
        child: AutoSizeText(
          text,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _containarwhite(
    String text,
    TextStyle style,
  ) {
    return GestureDetector(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 317,
        // width: 99.7,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(1),
            ),
          ],
        ),
        child: Center(
            child: AutoSizeText(
          text,
          style: style,
          textAlign: TextAlign.center,
        )),
      ),
    );
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
            '상세 정보',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const Text(
                        '출고번호',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                ),
                Expanded(
                    flex: 5,
                    child: Text(
                      '${widget.detailNumber}',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const Text(
                        '출고구분',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                ),
                Expanded(
                  flex: 5,
                  child: Obx(() {
                    return DropdownButton(
                      value: _controller
                          .selectedOutputend, // Use the value from the controller
                      items: _controller.outputEnd.value.map(
                        (outputEnd) {
                          return DropdownMenuItem(
                            value: outputEnd['CODE'] as int,
                            child: Center(
                              child: Text(outputEnd['CODE_NAME']),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                          _controller.setSelectedOutputend(
                              value); 
                          print(value);
                           });
                        }
                      },
                      icon: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 24,
                      isExpanded: true,
                    );
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const Text(
                        '마감',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                ),
                Expanded(
                  flex: 5,
                  child: Obx(() {
                    return DropdownButton(
                      value: _controller.selectedDeadline,
                      items: _controller.deadLine.value.map(
                        (deadLine) {
                          return DropdownMenuItem(
                            value: deadLine['CODE'] as int,
                            child: Center(
                                child: Text(
                              deadLine['CODE_NAME'],
                            )),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                          _controller.setSelectedDeadline(
                              value); 
                          print(value);
                           });
                        }
                      },
                      icon: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 24,
                      isExpanded: true,
                    );
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.black,
            ),
            // SizedBox(
            //   height: 15,
            // ),
            Expanded(
              child: Container(
                width: 390,
                child: Obx(() {
                  final detailData = _controller.detailData.value;
                  return ListView.builder(
                    itemCount: detailData.length,
                    itemBuilder: (context, index) {
                      final selectedItem = detailData[index];
                      return GestureDetector(
                        onTap: () async {
                          await _controller.colorBool(index);
                          setState(() {});
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                            color: _controller.selectColor(index),
                          )),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        _detailcontainar(
                                          '품번',
                                          GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                          index,
                                        ),
                                        _containarwhite(
                                          '${selectedItem["ITEM_CD"]}',
                                          GoogleFonts.lato(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        _detailcontainar(
                                            '품명',
                                            GoogleFonts.lato(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                            index

                                            // const Color.fromRGBO(
                                            //     240, 248, 255, 1),
                                            ),
                                        _containarwhite(
                                          '${selectedItem["ITEM_NM"]}',
                                          GoogleFonts.lato(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        _detailcontainar(
                                            '주문수량',
                                            GoogleFonts.lato(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                            index
                                            // const Color.fromRGBO(
                                            //     240, 248, 255, 1),
                                            ),
                                        _containarwhite(
                                          '${selectedItem["SO_QT"]}',
                                          GoogleFonts.lato(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        _detailcontainar(
                                            '출고수량',
                                            GoogleFonts.lato(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                            index
                                            // const Color.fromRGBO(
                                            //     240, 248, 255, 1),
                                            ),
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(1),
                                                ),
                                              ],
                                            ),
                                            child: TextField(
                                              controller: _controller
                                                  .outcontroller[index],
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  _detailcontainar(
                                      'LOT No.',
                                      GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      index
                                      // const Color.fromRGBO(240, 248, 255, 1),
                                      ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(1),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                          child: TextField(
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                      )),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
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
                ' 출고등록',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
