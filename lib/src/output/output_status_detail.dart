import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/controller/output/status_detail_controller.dart';

class OutputStatusDetail extends StatefulWidget {
  final String detailNumber;
  OutputStatusDetail({required this.detailNumber});

  @override
  State<OutputStatusDetail> createState() => _OutputStatusDetailState();
}

class _OutputStatusDetailState extends State<OutputStatusDetail> {
  late final OpDetailController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(OpDetailController());
    _controller.OutputStDetailData(widget.detailNumber);
  }

  Widget _detailcontainar(String text, TextStyle style, Color color) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 66,
            width: MediaQuery.of(context).size.width -311.6,
            // width: 99.7,
            decoration: BoxDecoration(
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(1),
                ),
              ],
            ),
            child: Center(
                child: Text(
              text,
              style: style,
              textAlign: TextAlign.center,
            )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller.OutputStDetailData(widget.detailNumber);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.7,
        title: Text(
          '상세 정보',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text('목록', style: GoogleFonts.lato(fontSize: 20)),
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 1,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ];
        },
        body: Obx(() {
          final detailData = _controller.detailData.value;
          return ListView.builder(
            itemCount: detailData.length,
            itemBuilder: (context, index) {
              final selectedItem = detailData[index];
              return Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(5, 15, 5, 10),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Colors.black.withOpacity(0.7))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              _detailcontainar(
                                '품번',
                                GoogleFonts.lato(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                                const Color.fromRGBO(240, 248, 255, 1),
                              ),
                              _detailcontainar(
                                '규격',
                                GoogleFonts.lato(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                                const Color.fromRGBO(240, 248, 255, 1),
                              ),
                              _detailcontainar(
                                'LOT NO',
                                GoogleFonts.lato(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                                const Color.fromRGBO(240, 248, 255, 1),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              _detailcontainar(
                                '${selectedItem["ITEM_CD"]}'
                                    .replaceAll('STR_', ''),
                                GoogleFonts.lato(fontSize: 15),
                                Colors.white,
                              ),
                              _detailcontainar('${selectedItem["ITEM_SPEC"]}',
                                  GoogleFonts.lato(fontSize: 15), Colors.white),
                              _detailcontainar(
                                  '${selectedItem["LOT_NB"]}'
                                      .replaceAll('STR_', ''),
                                  GoogleFonts.lato(fontSize: 15),
                                  Colors.white),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              _detailcontainar(
                                '품명',
                                GoogleFonts.lato(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                                const Color.fromRGBO(240, 248, 255, 1),
                              ),
                              _detailcontainar(
                                '출고수량',
                                GoogleFonts.lato(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                                const Color.fromRGBO(240, 248, 255, 1),
                              ),
                              _detailcontainar(
                                '',
                                GoogleFonts.lato(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                                const Color.fromRGBO(240, 248, 255, 1),
                              ),
                              
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              _detailcontainar(
                                '${selectedItem["ITEM_NM"]}'
                                    .replaceAll('STR_', ''),
                                GoogleFonts.lato(fontSize: 15),
                                Colors.white,
                              ),
                              _detailcontainar('${selectedItem["ISU_QT"]}',
                                  GoogleFonts.lato(fontSize: 15), Colors.white),
                              _detailcontainar(
                                  // '${selectedItem["LOT_NB"]}'
                                  //     .replaceAll('STR_', ''),
                                  '',
                                  GoogleFonts.lato(fontSize: 15),
                                  Colors.white),
                            
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
