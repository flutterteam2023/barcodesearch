import 'dart:ffi';

import 'package:barcodesearch/constants/collections_constants.dart';
import 'package:barcodesearch/constants/firebase_constants.dart';
import 'package:barcodesearch/features/Authentication/Values/my_user.dart';

class CreditManager{

  Future<void> creditAdd(int credit)async{
    if (credit!=null) {
      await FireCollection.collection(FirebaseConstants.usersCollection)
      .doc(MyUser().value!.uid)
      .update({"credit":credit})
      ; 
      
    }

  }
  void creditIncrement(int reward){
     MyUser().value!.credit =  MyUser().value!.credit+ (11-reward);
     CreditManager().creditAdd(MyUser().value!.credit);
  }
  void creditDiscrememnt(){
    MyUser().value!.credit = MyUser().value!.credit - 1;
    CreditManager().creditAdd(MyUser().value!.credit);
  }


}