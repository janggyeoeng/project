import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/controller/output/status_controller.dart';
import 'package:hnde_pda/src/output/output_status_detail.dart';
import 'package:hnde_pda/src/service/date_time.dart';

class OutputStatus extends StatelessWidget {
  OutputStatus({Key? key});

  final MyViewModel _viewModel = Get.put(MyViewModel());
  final OutPutController _controller = Get.put(OutPutController());
  final TextEditingController searchController = TextEditingController();
  

  Future<void> _outputdata() async {
    String searchKeyword = searchController.text;
    await _controller.OutputStatusData(
      _viewModel.selectedDateRange.start,
      _viewModel.selectedDateRange.end,
      searchKeyword,
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
            '출고 현황',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
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
                        '출고 일자',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Obx(() => Text(
                              "${_viewModel.selectedDateRange.start.toLocal().toString().split(' ')[0]} ~ ${_viewModel.selectedDateRange.end.toLocal().toString().split(' ')[0]}",
                              style: const TextStyle(fontSize: 17),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: IconButton(
                          onPressed: () async {
                            await _viewModel.selectDateRange(
                                context);
                          },
                          icon: const Icon(Icons.calendar_month, size: 28,))
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
                        '출고 번호',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(hintText: ' 출고번호를 입력하세요.'),
                      onSubmitted: (value) {
                        _outputdata();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                          onPressed: () async {
                            _outputdata();
                          },
                          icon: const Icon(Icons.search, size: 28,))
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
                height: 15,
              ),
              Expanded(
                //하단 Container
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 3,
                      )
                    ],
                  ),
                  child: Obx(
                    () => ListView.builder(
                      itemCount: _controller.outputlist.length,
                      itemBuilder: (context, index) {
                        final selectedItem = _controller.outputlist[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => OutputStatusDetail(
                                detailNumber: selectedItem["ISU_NB"],));
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
