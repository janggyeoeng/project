import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hnde_pda/src/scm_admin/scm_check_controller.dart';
import 'package:get/get.dart';

class InputRegister extends StatefulWidget {
  InputRegister({Key? key}) : super(key: key);

  @override
  State<InputRegister> createState() => _InputRegisterState();
}

class _InputRegisterState extends State<InputRegister> {
  
//   var focusNode = FocusNode(onKey: (node, event) {
//     if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
//         // Do something
//         // Next 2 line needed If you don't want to update the text field with new line.
//         // node.unfocus(); 
//         // return true;
//     }
//     return false;

// });

  ScmCheckController _controller = ScmCheckController();

  var focusNodes = FocusNode();
  var focusNodes2 = FocusNode();
  String testStd = '';

  bool outTap = false;

  TextInputType inputType = TextInputType.none;

  @override
  void initState() {
    setInputType(false);
    focusNodes2.addListener(() {
      print(focusNodes2.hasFocus);
      focusNodes2.hasFocus == false ? FocusScope.of(context).requestFocus(focusNodes) : '';
    });
    super.initState();
  }

  TextInputType getInputType(){
    print(this.inputType);
    return this.inputType;
  }

  Future<void> setInputType(bool bo)async{

    this.inputType = bo == true ? TextInputType.text : TextInputType.none;
    print(this.inputType);
  }

  Future<void>setFocus()async{
    FocusScope.of(context).requestFocus(focusNodes);
  }

  Future<void> pageUpdate()async{
    setState(() {
      
    });
  }

  TextEditingController txtCon = TextEditingController();
  TextEditingController txtCon2 = TextEditingController();

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
            'SCM 입고등록',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            //RawKeyboardListener(
              // focusNode: focusNodes,
              // onKey: (e){
              //           if(e.isKeyPressed(LogicalKeyboardKey.enter)){
              //             print('enter : ${e}');
              //           }
              // },
               Row( //child:
                children: [
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Center(
                        child: Container(
                          //width: 50,
                          child: TextField(
                            focusNode: focusNodes,
                            controller: txtCon,
                           autofocus: true,
                           cursorColor: Colors.transparent,
                           cursorWidth: 0,
                           keyboardType: TextInputType.none,//getInputType(),
                           decoration: InputDecoration(
                            border: InputBorder.none
                           ),
                           onSubmitted: (value) async{
                             //await _controller.printf(value);
                              print(value);
                              txtCon.text = '';
                           },
                           onChanged: (value){
                            //print('aaa');
                            //txtCon.text = '';
                           },
                          //  onTapOutside: (value){
                          //    print('ddd');
                          //    FocusScope.of(context).unfocus();
                          //    FocusScope.of(context).requestFocus(focusNodes);
                          //  },
                           
                          ),
                        ),
                      ),
                        Container(
                        padding: const EdgeInsets.all(7),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: const Text(
                            '바코드',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      ]
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Stack(
                              children:[
                                TextFormField(
                                  controller: txtCon2,
                                  focusNode: focusNodes2,
                                  cursorColor: Colors.transparent,
                                  cursorWidth: 0,
                                  decoration: InputDecoration(
                                    border: InputBorder.none
                                  ),
                                  onFieldSubmitted: (value){
                                    this.outTap = false;
                                    setFocus();
                                  },
                                ),
                                TextFormField(
                                  //controller: txtCon2,
                                  readOnly: true,
                                  cursorColor: Colors.transparent,
                                  cursorWidth: 0,
                                  decoration: InputDecoration(
                                    //border: InputBorder.none
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:Colors.grey
                                      )
                                    )  
                                  ),
                                  
                                  
                                ),
                              ] 
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              child: Container(
                                width: 20,
                                height: 20,
                                //color: Colors.green,
                                child: Icon(
                                  Icons.keyboard,
                                  color: Colors.blue,
                                ),
                              ),
                              onTap: ()async{
                                print('클릭');
                                  //FocusScope.of(context).unfocus();
                                  //await setInputType(true);
                                  this.outTap = true;
                                  FocusScope.of(context).requestFocus(focusNodes2);
                                  //print(this.inputType);
                                  //await pageUpdate();

                                  //await setFocus();
                                  //FocusScope.of(context).requestFocus(focusNodes);
                                
                              },
                            )
                          )
                        ],
                      ),
                    )
                    // TextField(
                    //   //autofocus: true,
                    //   decoration: InputDecoration(hintText: '바코드를 입력하세요'),
                    //   onSubmitted: (value){
                    //       print(value);
                    //   },
                    //   onTapOutside: (Value){
                    //    // print('포커스아웃');
                        
                    //     FocusScope.of(context).requestFocus(focusNodes);
                    //     FocusScope.of(context).unfocus();
                    //   },
                    // ),
                  ),
                ],
             // ),
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                        padding: const EdgeInsets.all(7),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: const Text(
                            '출고번호',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                ),
                Expanded(
                  flex: 7,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                      '출고번호',
                       style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container()
                      )
                    ]
                  )
                ),
                

              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                        padding: const EdgeInsets.all(7),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: const Text(
                            '거래처',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                ),
                Expanded(
                  flex: 7,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                      '화신',
                       style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container()
                      )
                    ]
                  )
                ),

              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Container(
                height: 1,
                color:  Colors.grey.shade800,
              ),
            ),
            

            Expanded(
              flex: 2,
              child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      
                    ),
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          //final selectedItem = _controller.outputlist[index];
                          return GestureDetector(
                            onTap: () {
                              // Get.to(() => OutputStatusDetail(
                              //     detailNumber: selectedItem["ISU_NB"],));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              height: 100, // 아이템 높이 지정
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
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.withOpacity(0.3),
                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15))
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '품번',
                                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              //color: Colors.grey.withOpacity(0.3),
                                              child: Center(
                                                child: Text(
                                                  'ITEM_CD',
                                                  style: const TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.grey.withOpacity(0.3),
                                              child: Center(
                                                child: Text(
                                                  '품명',
                                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              //color: Colors.grey.withOpacity(0.3),
                                              child: Center(
                                                child: Text(
                                                  'ITEM_NM',
                                                  style: const TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.withOpacity(0.3),
                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15))
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '단위',
                                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              //color: Colors.grey.withOpacity(0.3),
                                              child: Center(
                                                child: Text(
                                                  'UNIT_DC',
                                                  style: const TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.grey.withOpacity(0.3),
                                              child: Center(
                                                child: Text(
                                                  '입고수량',
                                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              //color: Colors.grey.withOpacity(0.3),
                                              child: Center(
                                                child: Text(
                                                  'ISU_QT',
                                                  style: const TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
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
                ' 입고등록',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}