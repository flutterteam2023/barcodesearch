import 'package:barcodesearch/Screens/login/login_screen.dart';
import 'package:go_router/go_router.dart';
part 'app_routes.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    
    GoRoute(
      name: "Login",
      path: Routes.LOGIN,
      builder: (context, state) => LoginScreen(),
    ),
  ],
);