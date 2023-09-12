import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/output/output_controller/output_register_detail_controller.dart';

class OutputRegisterDetail extends StatefulWidget {
  final String detailNumber;
  const OutputRegisterDetail({super.key, required this.detailNumber});

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.7,
          title: Text(
            '상세 정보',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
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
                        '주문번호',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                ),
                Expanded(
                    flex: 7,
                    child: Text(
                      widget.detailNumber,
                      style: const TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
            const SizedBox(
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
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                ),
                Expanded(
                  flex: 7,
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
                            _controller.setSelectedOutputend(value);
                            print(value);
                          });
                        }
                      },
                      icon: const Align(
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
            const SizedBox(
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
                  flex: 7,
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
                            _controller.setSelectedDeadline(value);
                            print(value);
                          });
                        }
                      },
                      icon: const Align(
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
            const SizedBox(
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
              child: SizedBox(
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
                          margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
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
                                        _controller.detailcontainar(
                                          '품번',
                                          GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                          index,
                                        ),
                                        _controller.containarwhite(
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
                                        _controller.detailcontainar(
                                            '품명',
                                            GoogleFonts.lato(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                            index

                                            // const Color.fromRGBO(
                                            //     240, 248, 255, 1),
                                            ),
                                        _controller.containarwhite(
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
                                        _controller.detailcontainar(
                                            '주문수량',
                                            GoogleFonts.lato(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                            index
                                            // const Color.fromRGBO(
                                            //     240, 248, 255, 1),
                                            ),
                                        _controller.containarwhite(
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
                                        _controller.detailcontainar(
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
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5, bottom: 8),
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
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp('[0-9]'))
                                              ],
                                              textAlign: TextAlign.center,
                                              onSubmitted: (value) async {
                                                print(_controller.detailData
                                                    .value[index]['CHK']);
                                                print(value);
                                                await _controller
                                                    .colorBool(index);
                                                setState(() {});
                                                await _controller.checkValue(
                                                    context, index, value);
                                                await _controller.setSelectItem(
                                                    index, value, 'ISU_QT');
                                              },
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
                                  _controller.detailcontainar(
                                      'Lot No.',
                                      GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      index
                                      // const Color.fromRGBO(240, 248, 255, 1),
                                      ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5, bottom: 8),
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
                                        keyboardType: TextInputType.text,
                                        textAlign: TextAlign.center,
                                        onSubmitted: (value) async {
                                          await _controller.colorBool(index);
                                          setState(() {});
                                          await _controller.selectItem(
                                              index, true);
                                          await _controller.setSelectItem(
                                              index, value, 'LOT_NB');
                                        },
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
                    ' 출고등록',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
            ),
            onTap: () async {
              await _controller.saveClick(context);
            },
          ),
        ),
      ),
    );
  }
}
