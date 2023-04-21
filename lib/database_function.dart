/*

List<String> productsList = productsString.split("\n").toList();
          print(productsString.length);
          for (var element in productsList) {
            final list = element.split(" : ");
            String barcode = list[0];
            String name = list[1];
            List<String> barcodeArray = [];
            List<String> nameArray = [];

            //Z, ZE, ZEY, ZEYC, ZEYCE,
            for (var i = 0; i < (name.length); i++) {
              final arrayitem = name.substring(0, i + 1);
              if (!nameArray.contains(arrayitem) && arrayitem != "") {
                nameArray.add(arrayitem);
              }
            }

            for (var i = 0; i < (barcode.length); i++) {
              final arrayitem = barcode.substring(0, i + 1);
              if (!barcodeArray.contains(arrayitem) && arrayitem != "") {
                barcodeArray.add(arrayitem);
              }
            }
            //reverse array create
            //Z, ZE, ZEY, ZEYC, ZEYCE, EYCE, YCE, CE, E
            for (var i = 0; i < (name.length); i++) {
              final arrayitem = name.substring(i, name.length);
              if (!nameArray.contains(arrayitem) && arrayitem != "") {
                nameArray.add(arrayitem);
              }
            }

            for (var i = 0; i < (barcode.length); i++) {
              final arrayitem = barcode.substring(i, barcode.length);
              if (!barcodeArray.contains(arrayitem) && arrayitem != "") {
                barcodeArray.add(arrayitem);
              }
            }

            print(nameArray);
            print(barcodeArray);

            final ProductModel product = ProductModel(
              name: name,
              barcode: barcode,
              photoURL: null,
              nameArray: nameArray,
              barcodeArray: barcodeArray,
            );
          }
          /*  
           await FirebaseFirestore.instance.collection("products").doc().set(
                  product.toMap(),
                );
          final product = ProductModel(
            name: "adasdas123",
            barcode: "123123",
            photoURL: null,
          );
          ProductList().add(product);
          await FirebaseFirestore.instance.collection("products").doc().set(
                product.toMap(),
              ); */ */