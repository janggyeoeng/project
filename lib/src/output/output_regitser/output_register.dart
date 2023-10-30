import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/auth_page.dart';
import 'package:hnde_pda/src/output/output_regitser/output_register_controller.dart';
import 'package:hnde_pda/src/output/output_regitser(back)/output_register_controller_back.dart';

import 'package:hnde_pda/src/output/output_register_detail/output_register_detail.dart';

class OutputRegister2 extends StatefulWidget {
  const OutputRegister2({Key? key}) : super(key: key);

  @override
  State<OutputRegister2> createState() => _OutputRegister2State();
}

class _OutputRegister2State extends State<OutputRegister2> {
  final OutPutRegisterController2 _controller =
      Get.put(OutPutRegisterController2());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.offAll(const AuthPage());
              },
              icon: const Icon(Icons.arrow_back)),
          elevation: 0.7,
          title: Text(
            '출고 등록',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 4, bottom: 7, right: 4, top: 7),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const AutoSizeText(
                        maxLines: 1,
                        '출고지시번호',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 6,
                      child: TextField(
                        onSubmitted: (value) async {
                          await _controller.outputStDetailData(value);
                          await _controller.setController();
                          await _controller.outputEndData();
                          await _controller.deadLineData();
                        },
                      )),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () async {},
                      icon: const Icon(
                        Icons.keyboard,
                        size: 28,
                      ),
                    ),
                  ),
                ],
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
                        value: _controller.model
                            .selectedOutputend, // Use the value from the controller
                        items: _controller.model.outputEnd.value.map(
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
                              _controller.model.setSelectedOutputend(value);
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
                        value: _controller.model.selectedDeadline,
                        items: _controller.model.deadLine.value.map(
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
                              _controller.model.setSelectedDeadline(value);
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
              const Divider(
                thickness: 5,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                height: 440,
                //width: 150,
                child: Column(
                  children: [
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          itemCount: _controller.model.detailData.value.length,
                          itemBuilder: (context, index) {
                            final selectedItem =
                                _controller.model.detailData.value[index];
                            return GestureDetector(
                              onTap: () {
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                  index
                                                  // const Color.fromRGBO(
                                                  //     240, 248, 255, 1),
                                                  ),
                                              _controller.containarwhite(
                                                '${selectedItem["ISUREQ_QT"]}',
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                  index
                                                  // const Color.fromRGBO(
                                                  //     240, 248, 255, 1),
                                                  ),
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5,
                                                          right: 5,
                                                          bottom: 8),
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
                                                        .getSearch()[index],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]'))
                                                    ],
                                                    textAlign: TextAlign.center,
                                                    onSubmitted: (value) async {
                                                      print(_controller
                                                          .model
                                                          .detailData
                                                          .value[index]['CHK']);
                                                      print(value);
                                                      await _controller
                                                          .colorBool(index);
                                                      setState(() {});
                                                      await _controller
                                                          .checkValue(context,
                                                              index, value);
                                                      await _controller
                                                          .setSelectItem(index,
                                                              value, 'ISU_QT');
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
                                                  color: Colors.black
                                                      .withOpacity(1),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                                child: TextField(
                                              keyboardType: TextInputType.text,
                                              textAlign: TextAlign.center,
                                              onSubmitted: (value) async {
                                                await _controller
                                                    .colorBool(index);
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
                        ),
                      ),
                    ),
                  ],
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
