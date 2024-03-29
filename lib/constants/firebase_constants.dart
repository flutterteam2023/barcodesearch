enum FirebaseConstants {
  productCollection,
  barcodeArrayField,
  nameArrayField,
  usersCollection,
  creditField,
}

extension FirebaseContantsName on FirebaseConstants {
  String get toName {
    switch (this) {
      case FirebaseConstants.productCollection:
        return 'products';
      case FirebaseConstants.barcodeArrayField:
        return 'barcodeArray';
      case FirebaseConstants.nameArrayField:
        return 'nameArray';
      case FirebaseConstants.usersCollection:
        return 'users';
      case FirebaseConstants.creditField:
        return 'credit';
    }
  }
}
