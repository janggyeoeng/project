import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ScmCheck extends StatefulWidget {
  ScmCheck({Key? key}) : super(key: key);

  @override
  State<ScmCheck> createState() => _ScmCheckState();
}

class _ScmCheckState extends State<ScmCheck> {
  
//   var focusNode = FocusNode(onKey: (node, event) {
//     if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
//         // Do something
//         // Next 2 line needed If you don't want to update the text field with new line.
//         // node.unfocus(); 
//         // return true;
//     }
//     return false;

// });

  var focusNodes = FocusNode();
  var focusNodes2 = FocusNode();
  String testStd = '';

  bool outTap = false;

  TextInputType inputType = TextInputType.none;

  @override
  void initState() {
    super.initState();
    setInputType(false);
    focusNodes2.addListener(() {
      print(focusNodes2.hasFocus);
      focusNodes2.hasFocus == false ? FocusScope.of(context).requestFocus(focusNodes) : '';
    });
  }

  TextInputType getInputType(){
    print(this.inputType);
    return this.inputType;
  }

  Future<void> setInputType(bool bo)async{

    this.inputType = bo == true ? TextInputType.text : TextInputType.none;
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
            'SCM 수입검사',
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
                           keyboardType: getInputType(),
                           decoration: InputDecoration(
                            //border: InputBorder.none
                           ),
                           onSubmitted: (value) {
                              print(value);
                           },
                           onChanged: (value){
                            print(value);
                            txtCon.text = '';
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
                        child: const Text(
                          '바코드',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
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
                                color: Colors.red,
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
                ' 수입검사',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}