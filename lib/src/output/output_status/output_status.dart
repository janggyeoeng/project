import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/output/output_status/output_status_controller.dart';

import 'package:hnde_pda/src/output/output_status_detail/output_status_detail.dart';

class OutputStatus extends StatelessWidget {
  OutputStatus({
    super.key,
  });

  final OutPutController _controller = Get.put(OutPutController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            '출고 현황',
            style: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const Text(
                        '출고일자',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Obx(() => Text(
                              "${_controller.model.selectedDateRange.start.toLocal().toString().split(' ')[0]} ~ ${_controller.model.selectedDateRange.end.toLocal().toString().split(' ')[0]}",
                              style: const TextStyle(fontSize: 17),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () async {
                            await _controller.selectDate(context);
                            _controller.outputdata();
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            size: 28,
                          ))
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     await _viewModel
                      //         .selectDateRange(context);
                      //   },
                      //   child: const Icon(
                      //     Icons.calendar_today_rounded,
                      //     size: 27,
                      //   ),
                      // ),
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
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const Text(
                        '거래처',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 3),
                      child: TextField(
                        controller: _controller.getSearch(),
                        decoration:
                            const InputDecoration(hintText: ' 거래처를 입력하세요.'),
                        onSubmitted: (value) {
                          _controller.outputdata();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () async {
                            _controller.outputdata();
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 28,
                          ))
                      // ElevatedButton(
                      //   onPressed: () {
                      //     _outputdata();
                      //   },
                      //   child: Text(
                      //     '검색',
                      //     style: GoogleFonts.lato(fontSize: 18),
                      //   ),
                      // ),
                      ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: _controller.model.outputlist.length,
                      itemBuilder: (context, index) {
                        final selectedItem =
                            _controller.model.outputlist[index];
                        return GestureDetector(
                          onTap: () async {
                            await _controller.setInfo(index);
                            Get.to(() => OutputStatusDetail(
                                  trNm: _controller.model.trNm,
                                  detailNumber: selectedItem["ISU_NB"],
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            height: 125, // 아이템 높이 지정
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
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${selectedItem["ISU_NB"]}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        selectedItem["TR_NM"],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${selectedItem["ISU_DT"]}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '${selectedItem["RMK_DC"]}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
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
        ),
      ),
    );
  }
}
