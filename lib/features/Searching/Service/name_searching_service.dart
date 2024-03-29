import 'package:barcodesearch/constants/collections_constants.dart';
import 'package:barcodesearch/constants/firebase_constants.dart';
import 'package:barcodesearch/features/Searching/Models/product_model.dart';
import 'package:barcodesearch/features/Searching/Values/product_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NameSearchingService {
  static DocumentSnapshot? lastDocument;
  static bool isLastPage = false;
  final pageSize = 10;
  final ProductList productList = ProductList();

  Future<void> searchInitiliaze({required String text}) async {
    await FireCollection.collection(FirebaseConstants.productCollection)
        .where(FirebaseConstants.nameArrayField.toName, arrayContains: text)
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
          for (final element in value.docs) {
            if (!productList.value.contains(element.data())) {
              productList.add(element.data());
            }
          }

          if (value.docs.length < pageSize) {
            isLastPage = true;
          }
          lastDocument = value.docs.last;
        } else {
          isLastPage = true;
        }
      },
    );
  }

  Future<void> loadMoreData({required String text}) async {
    debugPrint('loaded more working');
    if (!isLastPage) {
      if (lastDocument != null) {
        await FireCollection.collection(FirebaseConstants.productCollection)
            .where(FirebaseConstants.nameArrayField.toName, arrayContains: text)
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
              for (final element in value.docs) {
                if (!productList.value.contains(element.data())) {
                  productList.add(element.data());
                }
              }

              if (value.docs.length < pageSize) {
                isLastPage = true;
              }

              lastDocument = value.docs.last;
            } else {
              isLastPage = true;
            }
          },
        );

        debugPrint('loaded more data');
      }
    } else {
      debugPrint('is last page ${ProductList().length}');
    }
  }
}
