import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/output/output_order_detail/output_order_detail_controller.dart';

class OutPutOrderDetail extends StatefulWidget {
  const OutPutOrderDetail({super.key});

  @override
  State<OutPutOrderDetail> createState() => _OutPutOrderDetailState();
}

OutPutOrderDetailController _controller = OutPutOrderDetailController();

class _OutPutOrderDetailState extends State<OutPutOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('출고 지시 세부 사항',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    alignment: Alignment.center,
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
                        fontSize: 17,
                      ),
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
                    child: const Text(
                      'widget.detailNumber',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    alignment: Alignment.center,
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
                        fontSize: 17,
                      ),
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
                    child: const Text(
                      '',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black)),
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
                                    'ITEM_CD',
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
                                    'ITEM_NM',
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
                                    'ISU_QT',
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
                                            color: Colors.black.withOpacity(1),
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]'))
                                        ],
                                        textAlign: TextAlign.center,
                                        onSubmitted: (value) async {},
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
                                    fontWeight: FontWeight.bold, fontSize: 15),
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
                                  onSubmitted: (value) async {},
                                )),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
