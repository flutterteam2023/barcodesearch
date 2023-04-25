import 'package:barcodesearch/constants/searching_constants.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<SearchingConstants>(SearchingConstants());
}
