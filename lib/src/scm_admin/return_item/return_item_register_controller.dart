import 'package:hnde_pda/src/scm_admin/return_item/return_item_register_model.dart';

class ReturnRegisterController {
  ReturnRegisterModel model = ReturnRegisterModel();

  Future<void> returnItem() async {
    return model.returnItem();
  }
}
