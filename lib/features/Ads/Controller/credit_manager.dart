import 'package:barcodesearch/constants/collections_constants.dart';
import 'package:barcodesearch/constants/firebase_constants.dart';
import 'package:barcodesearch/features/Authentication/Values/my_user.dart';

class CreditManager {
  Future<void> creditAdd(int? credit) async {
    if (credit != null) {
      await FireCollection.collection(FirebaseConstants.usersCollection)
          .doc(MyUser().value!.uid)
          .update({FirebaseConstants.creditField.toName: credit});
    }
  }

  Future<void> creditIncrement(int incrementNumber) async {
    if (!MyUser().isNull()) {
      MyUser().creditUpdate(
        (MyUser().getCredit() ?? 0) + incrementNumber,
      );
      await CreditManager().creditAdd(MyUser().value!.credit);
    }
  }

  Future<bool> creditDiscrememnt(int discrementNumber) async {
    //işlem gerçekleştiyse true gerçekleşmediyse false döner,
    if (!MyUser().isNull() && (MyUser().getCredit() ?? 0) > 0) {
      MyUser().creditUpdate(
        (MyUser().getCredit() ?? 0) - discrementNumber,
      );
      await CreditManager().creditAdd(MyUser().value!.credit);
      return true;
    } else {
      return false;
      print("krediniz yetersiz uyarısı");
    }
  }
}
