
import 'package:hnde_pda/src/scm_admin/scm_check_model.dart';
import 'package:flutter/material.dart';


class ScmCheckController {

  ScmCheckModel model = ScmCheckModel();

  Future<void> pageLoad()async{
    await model.pageLoad();
  }

  Future<void> setKeyboardClick(bool bo)async{
    await model.setKeyboardClick(bo);
  }

  dynamic textFocusListner(BuildContext context){
    return model.textFocusListner(context);
  }

  dynamic barcodeFocusListner(BuildContext context){
    return model.barcodeFocusListner(context);
  }

  FocusNode getTextNode(){
    return  model.getTextNode();
  }

  FocusNode getBarcodeNode(){
    return model.getBarcodeNode();
  }

  Future<void>setFocus(BuildContext context)async{
    model.setFocus(context);
  }

}