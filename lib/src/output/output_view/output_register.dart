import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/auth_page.dart';
import 'package:hnde_pda/src/output/output_controller/output_register_controller.dart';

import 'package:hnde_pda/src/output/output_view/output_register_detail.dart';

class OutputRegister extends StatelessWidget {
  OutputRegister({Key? key}) : super(key: key);

  final OutPutRegisterController _controller =
      Get.put(OutPutRegisterController());

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
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
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
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const Text(
                        '주문일자',
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
                              "${_controller.datechk.selectedDateRange.start.toLocal().toString().split(' ')[0]} ~ ${_controller.datechk.selectedDateRange.end.toLocal().toString().split(' ')[0]}",
                              style: const TextStyle(fontSize: 17),
                              textAlign: TextAlign.center,
                              //overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () async {
                            await _controller.datechk.selectDateRange(
                                context); // Call selectDateRange
                            _controller.outputregisterdata();
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            size: 28,
                          ))),
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
                          '주문번호',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.only(left: 5, right: 25),
                      child: TextField(
                        controller: _controller.searchController,
                        decoration:
                            const InputDecoration(hintText: '주문번호를 입력하세요.'),
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
                          '거래처',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: TextField(
                        controller: _controller.customerController,
                        decoration:
                            const InputDecoration(hintText: ' 거래처를 입력하세요.'),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            _controller.outputregisterdata();
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 28,
                          ))),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(7),
                height: 440,
                //width: 150,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        _controller.container('주문번호'),
                        _controller.container('주문일자'),
                        _controller.container('거래처'),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          itemCount: _controller.outputregisterlist.length,
                          itemBuilder: (context, index) {
                            final selectedItem =
                                _controller.outputregisterlist[index];
                            return GestureDetector(
                              onTap: () {
                                print(selectedItem["SO_NB"]);
                                Get.to(() => OutputRegisterDetail(
                                    detailNumber: selectedItem["SO_NB"]));
                              },
                              child: SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _controller.expanded(
                                            '${selectedItem["SO_NB"]}'),
                                        _controller.expanded(
                                          '${selectedItem["SO_DT"]}'
                                              .replaceAll('TSST_', ''),
                                        ),
                                        _controller.expanded(
                                          '${selectedItem["TR_NM"]}'
                                              .replaceAll('TSST_', ''),
                                        ),
                                      ],
                                    ),
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
      ),
    );
  }
}
