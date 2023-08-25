import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/auth_page.dart';
import 'package:hnde_pda/src/controller/output/register_controller.dart';
import 'package:hnde_pda/src/output/output_register_detail.dart';
import 'package:hnde_pda/src/service/date_time.dart';

class OutputRegister extends StatelessWidget {
  OutputRegister({Key? key}) : super(key: key);
  final MyViewModel _viewModel = Get.put(MyViewModel());
  //final RxString selectedItem = RxString("");
  final OutPutRegisterController _controller =
      Get.put(OutPutRegisterController());
  final TextEditingController searchController = TextEditingController();
  final TextEditingController customerController = TextEditingController();

  Future<void> _outputregisterdata() async {
    String searchKeyword = searchController.text;
    String customerKeyword = customerController.text;
    await _controller.OutputRegisterData(_viewModel.selectedDateRange.start,
        _viewModel.selectedDateRange.end, searchKeyword, customerKeyword);
  }

  Widget _container(String text) {
    return Expanded(
        flex: 2,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.3)),
              color: Color(0xFF3E8EDE),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            )));
  }

  Widget _expanded(String text) {
    return Expanded(
        flex: 2,
        child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.01)),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            )));
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
          leading: IconButton(onPressed: (){
            Get.offAll(AuthPage());
          }, icon: Icon(Icons.arrow_back)),
          elevation: 0.7,
          title: Text(
            '출고 등록',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
          
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
                              //overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: IconButton(
                          onPressed: () async {
                            await _viewModel.selectDateRange(
                                context); // Call selectDateRange
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
                              fontSize: 17, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Expanded(
                    flex: 7,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(hintText: '주문번호를 입력하세요.'),
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
                    flex: 5,
                    child: TextField(
                      controller: customerController,
                      decoration: InputDecoration(hintText: ' 거래처를 입력하세요.'),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: IconButton(
                          onPressed: () {
                            _outputregisterdata();
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
                height: 370,
                //width: 150,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        _container('주문번호'),
                        _container('주문일자'),
                        _container('거래처'),
                      ],
                    ),
                    SizedBox(
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
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _expanded('${selectedItem["SO_NB"]}'),
                                        _expanded(
                                          '${selectedItem["SO_DT"]}'
                                              .replaceAll('TSST_', ''),
                                        ),
                                        _expanded(
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
