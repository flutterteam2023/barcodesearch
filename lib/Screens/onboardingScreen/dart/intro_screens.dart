import 'package:barcodesearch/Screens/home_screen.dart';
import 'package:barcodesearch/Screens/login/login_screen.dart';
import 'package:barcodesearch/Shared/AppRoute/route_constants.dart';
import 'package:barcodesearch/Shared/Widgets/onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroScreen extends StatefulWidget {
  final List<OnBoardingData> onbordingDataList;
  final MaterialPageRoute pageRoute;
  const IntroScreen(
    this.onbordingDataList,
    this.pageRoute,
  );

  void goToHomePage(BuildContext context) {
    Navigator.push(context, pageRoute);
  }

  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final PageController controller = PageController();
  int currentPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }

  Widget _buildPageIndicator(int page) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: page == currentPage ? 10.0 : 6.0,
      width: page == currentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: page == currentPage ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEEEEE),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: PageView(
              controller: controller,
              onPageChanged: _onPageChanged,
              children: widget.onbordingDataList,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text(
                    "SKIP",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () => widget.goToHomePage(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      _buildPageIndicator(0),
                      _buildPageIndicator(1),
                      _buildPageIndicator(2),
                    ],
                  ),
                ),
                TextButton(
                  child: Text(
                    currentPage == widget.onbordingDataList.length - 1
                        ? "GOT IT"
                        : "NEXT",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if (currentPage == widget.onbordingDataList.length - 1) {
                      Future.delayed(const Duration(), () {
                        context.pushNamed(APP_PAGE.home.toName);
                      });
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
