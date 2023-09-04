import 'package:flutter/material.dart';

class ScmCheckModel{

  var barcodeFocusNodes = FocusNode();
  var textFocusNodes = FocusNode();
  bool keyboardClick = false;

  Future<void> pageLoad()async{

  }

  Future<void> setKeyboardClick(bool bo)async{
    this.keyboardClick = bo;
    print('불값 : ${this.keyboardClick}');
  }

  FocusNode getTextNode(){
    return this.textFocusNodes;
  }

  FocusNode getBarcodeNode(){
    return this.barcodeFocusNodes;
  }
  
  dynamic textFocusListner(BuildContext context){
    return textFocusNodes.addListener(() {
      print(textFocusNodes.hasFocus);
      if(textFocusNodes.hasFocus == false){
        this.keyboardClick = false;
        FocusScope.of(context).requestFocus(barcodeFocusNodes);
      }
      
    });
  }

  dynamic barcodeFocusListner(BuildContext context){
    return barcodeFocusNodes.addListener(() {
      print('리스너가 먼저?');
      if(barcodeFocusNodes.hasFocus == false && this.keyboardClick == false){
        FocusScope.of(context).requestFocus(barcodeFocusNodes);
        print('딴거 눌렀으니 이동');
      }else{
        print('정상클릭했음');
      }


      //barcodeFocusNodes.hasFocus == false ? FocusScope.of(context).requestFocus(barcodeFocusNodes) : '';
    });
  }

  Future<void>setFocus(BuildContext context)async{
    //this.keyboardClick = false;
    FocusScope.of(context).requestFocus(this.textFocusNodes);
  }
    
}