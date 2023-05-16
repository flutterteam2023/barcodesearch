// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:barcodesearch/common_widgets/app_buttons.dart';
import 'package:barcodesearch/common_widgets/input_field.dart';
import 'package:barcodesearch/common_widgets/dialog.dart';
import 'package:barcodesearch/features/Authentication/Values/my_user.dart';
import 'package:barcodesearch/features/Authentication/Widgets/register.dart';
import 'package:barcodesearch/features/Authentication/Widgets/reset.dart';
import 'package:barcodesearch/features/Authentication/login_manager.dart';
import 'package:barcodesearch/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class SuggestionView extends StatefulWidget {
  @override
  _SuggestionViewState createState() => _SuggestionViewState();
}

class _SuggestionViewState extends State<SuggestionView> {
  late TextEditingController productNameController;
  late TextEditingController productBarcodeNumberController;
  String? downloadURL;
  ValueNotifier<Uint8List?> imageFile = ValueNotifier(null);
  @override
  void initState() {
    super.initState();

    productNameController = TextEditingController();
    productBarcodeNumberController = TextEditingController();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productBarcodeNumberController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  Widget loginButton() {
    return AppButtons.roundedButton(
      borderRadius: BorderRadius.circular(14),
      backgroundColor: Colors.indigo,
      text: 'Gönder',
      function: () async {
        if (FirebaseAuth.instance.currentUser == null) {
          unawaited(
            Flushbar<Widget>(
              title: 'Giriş yapmanız gerekmektedir.',
              message: 'Yeni öneride bulunmak için öncelikle giriş yapınız',
              duration: const Duration(seconds: 3),
            ).show(context),
          );
        }

        if (imageFile.value == null) {
          unawaited(
            Flushbar<Widget>(
              title: 'Fotoğraf eklemeniz gerekmektedir',
              message: 'Yeni öneride bulunmak için öncelikle fotoğraf ekleyiniz.',
              duration: const Duration(seconds: 3),
            ).show(context),
          );
        }

        if (productNameController.text.isEmpty) {
          unawaited(
            Flushbar<Widget>(
              title: 'Ürün adını giriniz',
              message: 'Eklemek istediğiniz ürün adını giriniz.',
              duration: const Duration(seconds: 3),
            ).show(context),
          );
        }

        if (productBarcodeNumberController.text.isEmpty) {
          unawaited(
            Flushbar<Widget>(
              title: 'Ürün barkodunu giriniz',
              message: 'Eklemek istediğiniz ürün barkodunu girin veya okutun.',
              duration: const Duration(seconds: 3),
            ).show(context),
          );
        }

        if (FirebaseAuth.instance.currentUser != null &&
            imageFile.value != null &&
            productNameController.text.isNotEmpty &&
            productBarcodeNumberController.text.isNotEmpty) {
          try {
            var ref = FirebaseStorage.instance.ref().child('suggestions');
            final id = const Uuid().v1();
            ref = ref.child(id);

            final uploadTask = ref.putData(
              imageFile.value!,
              SettableMetadata(contentType: 'image/png'),
            );
            final snapshot = await uploadTask;
            final downloadUrl = await snapshot.ref.getDownloadURL();
            downloadURL = downloadUrl;

            final documentRef = FirebaseFirestore.instance.collection('suggestion').doc();
            await documentRef.set({
              'barcodeNo': productBarcodeNumberController.text,
              'dateOfSending': Timestamp.now(),
              'name': productNameController.text,
              'photoUrl': downloadURL,
              'userId': FirebaseAuth.instance.currentUser?.uid,
            });

            productBarcodeNumberController.clear();
            productNameController.clear();
            downloadURL = null;
            imageFile.value = null;
            Navigator.of(context).pop();
            unawaited(
              Flushbar<Widget>(
                title: 'Teşekkürler Öneriniz Başarıyla Gönderildi',
                message: 'Öneriniz onaylandığında 250 kredi alacaksınız',
                duration: const Duration(seconds: 3),
              ).show(context),
            );
          } catch (e) {
            unawaited(
              Flushbar<Widget>(
                title: 'Beklenmedik bir hata oluştu',
                message: '$e',
                duration: const Duration(seconds: 3),
              ).show(context),
            );
          }
        }

        await Future.delayed(const Duration(milliseconds: 100));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Barkod önerisi yapın',
                  style: heading2.copyWith(color: textBlack),
                ),
                Text(
                  'Onaylanırsa 250 kredi kazanın',
                  style: heading5.copyWith(color: Colors.indigo),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            Column(
              children: [
                InputField(
                  controller: productNameController,
                  hintText: 'Ürün Adı',
                  suffixIcon: const SizedBox(),
                ),
                const SizedBox(
                  height: 32,
                ),
                InputField(
                  hintText: 'Barkod Numarası',
                  controller: productBarcodeNumberController,
                  suffixIcon: IconButton(
                    color: textGrey,
                    splashRadius: 1,
                    icon: const Icon(
                      Icons.qr_code_scanner,
                    ),
                    onPressed: () async {
                      await FlutterBarcodeScanner.scanBarcode(
                        '#ff6666',
                        'Cancel',
                        false,
                        ScanMode.BARCODE,
                      ).then((value) {
                        if (value != "-1") {
                          productBarcodeNumberController.text = value;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ValueListenableBuilder(
                  valueListenable: imageFile,
                  builder: (context, value, setstate) {
                    return Column(
                      children: [
                        if (imageFile.value != null)
                          Image.memory(
                            imageFile.value!,
                            height: 150,
                            width: 150,
                          ),
                        if (imageFile.value == null)
                          AppButtons.roundedButton(
                            borderRadius: BorderRadius.circular(14),
                            backgroundColor: const Color(0xfff1f1f5),
                            text: 'Fotoğraf Yükle',
                            textStyle: TextStyle(
                              color: textGrey,
                              fontSize: 18,
                            ),
                            iconData: Icon(Icons.photo, color: textGrey),
                            function: () async {
                              showCustomModelBottomSheet(
                                context,
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Ürünün ve barkodunun net gözüktüğü bir fotoğraf yükleyiniz.',
                                        style: heading6.copyWith(color: Colors.grey[600], fontSize: 18),
                                      ),
                                      const SizedBox(height: 18),
                                      Text(
                                        'Yüklediğiniz fotoğraf ürünün onay sürecinde incelenecektir.',
                                        style: heading6.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const Divider(),
                                      ListTile(
                                        onTap: () async {
                                          final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                                          if (pickedFile != null) {
                                            imageFile.value = await XFile(pickedFile.path).readAsBytes();
                                            Navigator.of(context).pop();
                                            print('çalıştı');
                                          } else {
                                            debugPrint('görsel seçilemedi');
                                          }
                                        },
                                        title: const Text('Kamera ile yükle'),
                                        trailing: const Icon(Icons.arrow_forward_ios),
                                      ),
                                      const Divider(),
                                      ListTile(
                                        onTap: () async {
                                          final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                          if (pickedFile != null) {
                                            imageFile.value = await XFile(pickedFile.path).readAsBytes();
                                            Navigator.of(context).pop();
                                            print('çalıştı');
                                          } else {
                                            debugPrint('görsel seçilemedi');
                                          }
                                        },
                                        title: const Text('Galeri ile yükle'),
                                        trailing: const Icon(Icons.arrow_forward_ios),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                                isScrollControlled: false,
                              );
                            },
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            loginButton(),
          ],
        ),
      ),
    );
  }
}
