import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/output/output_status_detail/output_status_detail_controller.dart';

class OutputStatusDetail extends StatefulWidget {
  String detailNumber;
  String trNm = '';

  OutputStatusDetail(
      {super.key, required this.detailNumber, required this.trNm});

  @override
  State<OutputStatusDetail> createState() => _OutputStatusDetailState();
}

class _OutputStatusDetailState extends State<OutputStatusDetail> {
  late final OpDetailController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(OpDetailController());
    _controller.outputStDetailData(widget.detailNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.7,
        title: Text(
          '상세 정보',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(5),
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
                      child: Text(
                        widget.detailNumber,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
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
                child: Obx(() {
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
                                      Colors.grey.shade300,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: _controller.detailcontainar(
                                      '${selectedItem["ITEM_CD"]}',
                                      GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: _controller.detailcontainar(
                                      '품명',
                                      GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      Colors.grey.shade300,
                                    ),
                                  ),
                                  Expanded(
                                    child: _controller.detailcontainar(
                                      '${selectedItem["ITEM_NM"]}',
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
                                      '규격',
                                      GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      Colors.grey.shade300,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: _controller.detailcontainar(
                                      '${selectedItem["ITEM_SPEC"]}',
                                      GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: _controller.detailcontainar(
                                      '출고수량',
                                      GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      Colors.grey.shade300,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: _controller.detailcontainar(
                                      '${selectedItem["ISU_QT"]}',
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
                                      'Lot No.',
                                      GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      Colors.grey.shade300,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 66,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(1),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${selectedItem["LOT_NB"]}',
                                            style: GoogleFonts.lato(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ));
                    },
                  );
                }),
              )
            ],
          )),
    );
  }
}
