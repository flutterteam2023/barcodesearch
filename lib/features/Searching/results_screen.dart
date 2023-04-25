import 'package:barcodesearch/features/Searching/Models/product_model.dart';
import 'package:barcodesearch/features/Searching/Service/barcode_searching_service.dart';
import 'package:barcodesearch/features/Searching/Service/name_searching_service.dart';
import 'package:barcodesearch/features/Searching/Values/product_list.dart';
import 'package:barcodesearch/features/Searching/details_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.searchedText});
  final String searchedText;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        BarcodeSearchingService().loadMoreData(text: widget.searchedText);
        NameSearchingService().loadMoreData(text: widget.searchedText);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loading = false;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Arama Sonuçları:\n${widget.searchedText}',
          style: GoogleFonts.poppins(
            fontSize: 18,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: ProductList(),
        builder: (context, value, _) {
          return AnimationLimiter(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: ProductList().length + 1,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (BarcodeSearchingService.isLastPage &&
                    NameSearchingService.isLastPage &&
                    ProductList().length == 0) {
                  return const Center(
                    child: Text('ürün bulunamadı.'),
                  );
                } else if (BarcodeSearchingService.isLastPage &&
                    NameSearchingService.isLastPage &&
                    index == ProductList().length) {
                  return Center(
                    child: Text('${ProductList().length} ürün bulundu.'),
                  );
                } else if (index == ProductList().length) {
                  return SizedBox.square(
                    dimension: 50,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  final product = ProductList().getIndex(index);
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    delay: const Duration(milliseconds: 100),
                    child: SlideAnimation(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      horizontalOffset: 30,
                      verticalOffset: 300,
                      child: FlipAnimation(
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        flipAxis: FlipAxis.y,
                        child: Bounceable(
                          onTap: () {
                            showDetailsSheet(
                              context: context,
                              product: product,
                            );
                          },
                          child: Column(
                            children: [
                              const Divider(),
                              ListTile(
                                title: Text(
                                  product.name ?? '',
                                  style: GoogleFonts.poppins(),
                                ),
                                trailing: const Icon(
                                  Iconsax.arrow_right_3,
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
