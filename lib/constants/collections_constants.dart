import 'package:barcodesearch/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireCollection {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> collection(
    FirebaseConstants constants,
  ) =>
      db.collection(constants.toName);
}
