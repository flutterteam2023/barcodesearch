import 'package:barcodesearch/Service/barcode_searching_service.dart';
import 'package:barcodesearch/Service/name_searching_service.dart';
import 'package:barcodesearch/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
        title: Text("Arama Sonuçları:\n${widget.searchedText}"),
      ),
      body: ValueListenableBuilder(
        valueListenable: ProductList(),
        builder: (context, value, _) {
          return AnimationLimiter(
            child: NotificationListener(
              onNotification: (t) {
                final nextPageTrigger =
                    0.8 * _scrollController.positions.last.maxScrollExtent;

                if (_scrollController.positions.last.axisDirection ==
                        AxisDirection.down &&
                    _scrollController.positions.last.pixels >=
                        nextPageTrigger) {
                  if (loading == false) {
                    loading = true;
                    BarcodeSearchingService()
                        .loadMoreData(text: widget.searchedText);
                    NameSearchingService()
                        .loadMoreData(text: widget.searchedText);
                    Future.delayed(Duration(seconds: 2), () {
                      loading = false;
                    });
                  }
                }
                return true;
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: ProductList().length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
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
                        child: Column(
                          children: [
                            const Divider(),
                            ListTile(
                              title: Text(
                                ProductList().getIndex(index).name ?? "",
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
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
