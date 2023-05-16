import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppButtons {
  AppButtons(this.context);
  final BuildContext context;
  static InkWell roundedButton({
    Future<void> Function()? function,
    String? text,
    bool? isLoadingButton,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    Icon? iconData,
    TextStyle? textStyle,
  }) {
    final isSignInLoading = ValueNotifier<bool>(false);
    return InkWell(
      borderRadius: borderRadius ?? BorderRadius.circular(99),
      onTap: () async {
        if (isSignInLoading.value == false) {
          isSignInLoading.value = true;
          await function?.call().then(
                (value) => isSignInLoading.value = false,
              );
        } else {
          print("APP_BUTTONS_ERROR");
        }
        isSignInLoading.value = false;
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.deepOrange,
          borderRadius: borderRadius ?? BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
        child: ValueListenableBuilder(
          valueListenable: isSignInLoading,
          builder: (context, value, _) {
            if (value) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox.square(
                    dimension: 21,
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      size: 21,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if ((isLoadingButton ?? false) == true)
                    const SizedBox(
                      height: 23,
                      width: 23,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (iconData != null) iconData,
                        Text(
                          text ?? '',
                          style: textStyle ??
                              const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget futureButton({
    Future<void> Function()? function,
    String? text,
    Color? backgroundColor,
    Widget? indicator,
    Color? textColor,
    BoxBorder? border,
  }) {
    final isLoading = ValueNotifier<bool>(false);

    return InkWell(
      borderRadius: BorderRadius.circular(99),
      onTap: () async {
        isLoading.value = true;
        await function?.call().then((value) => isLoading.value = false);
      },
      child: Container(
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                if (value == true) {
                  return SizedBox(
                    height: 23,
                    width: 23,
                    child: indicator ?? const CircularProgressIndicator(),
                  );
                } else {
                  return Text(
                    text ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      color: textColor ?? Colors.black,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget futureFloatingActionButton({
    Future<void> Function()? function,
    IconData? iconData,
  }) {
    final isLoading = ValueNotifier<bool>(false);

    return FloatingActionButton(
      onPressed: () async {
        isLoading.value = true;
        await function?.call().then((value) => isLoading.value = false);
      },
      child: ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, value, child) {
          if (value == true) {
            return const SizedBox(
              height: 23,
              width: 23,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else {
            return Icon(iconData);
          }
        },
      ),
    );
  }
}
