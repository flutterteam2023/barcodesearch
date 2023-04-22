import 'package:barcodesearch/Models/product_model.dart';
import 'package:barcodesearch/product_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Shared/Constants/firebase_constants.dart';

class NameSearchingService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  static DocumentSnapshot? lastDocument;
  static bool isLastPage = false;
  final pageSize = 10;
  final ProductList productList = ProductList();

  Future<void> searchInitiliaze({required String text}) async {
    await db
        .collection(FirebaseConstants.productCollection)
        .where(FirebaseConstants.nameArrayField, arrayContains: text)
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, _) =>
              ProductModel.fromMap(snapshot.data()!),
          toFirestore: (model, _) => model.toMap(),
        )
        .limit(pageSize)
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            if (!productList.value.contains(element.data())) {
              productList.add(element.data());
            }
          }

          if (value.docs.length < pageSize) {
            print(value.docs.length);
            isLastPage = true;
          }
          lastDocument = value.docs.last;
        }
      },
    );
  }

  Future<void> loadMoreData({required String text}) async {
    debugPrint("loaded more working");
    if (!isLastPage) {
      if (lastDocument != null) {
        await db
            .collection(FirebaseConstants.productCollection)
            .where(FirebaseConstants.nameArrayField, arrayContains: text)
            .withConverter<ProductModel>(
              fromFirestore: (snapshot, _) =>
                  ProductModel.fromMap(snapshot.data()!),
              toFirestore: (model, _) => model.toMap(),
            )
            .startAfterDocument(lastDocument!)
            .limit(pageSize)
            .get()
            .then(
          (value) {
            if (value.docs.isNotEmpty) {
              for (var element in value.docs) {
                if (!productList.value.contains(element.data())) {
                  productList.add(element.data());
                }
              }

              if (value.docs.length < pageSize) {
                isLastPage = true;
              }
              lastDocument = value.docs.last;
            }
          },
        );

        debugPrint("loaded more data");
      }
    } else {
      debugPrint("is last page ${ProductList().length}");
    }
  }
}
