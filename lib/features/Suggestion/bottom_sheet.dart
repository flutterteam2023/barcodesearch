import 'package:barcodesearch/common_widgets/dialog.dart';
import 'package:barcodesearch/features/Suggestion/suggestion_view.dart';
import 'package:flutter/material.dart';

void suggestionModalBottomSheet(BuildContext context) {
  showCustomModelBottomSheet(
    context,
    const SuggestionView(),
  );
}
