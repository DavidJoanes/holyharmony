import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'controllers/constants.dart';
import 'controllers/session_controller.dart';
import 'controllers/session_manger.dart';
import 'models/state_model.dart';
import 'models/theme_model.dart';
import 'screens/error_page.dart';
import 'screens/explore.dart';
import 'screens/home_frame.dart';
import 'screens/home_page.dart';
import 'screens/signin.dart';
import 'screens/signup.dart';
import 'widgets/custom_snackbar.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final sectionNavigatorKey = GlobalKey<NavigatorState>();
SessionController session = SessionController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setPathUrlStrategy();
  await GetStorage.init();
  runApp(MyApp());
}

final constantValues = Get.put(Constants());
var userInfo = GetStorage();

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class ThemeProvider with ChangeNotifier {
  ThemeMode selectedThemeMode = ThemeMode.system;

  setSelectedThemeMode(bool comparator) {
    selectedThemeMode = comparator ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter router = GoRouter(
      navigatorKey: rootNavigatorKey,
      redirect: (BuildContext context, GoRouterState state) {
        if (userInfo.read("userData").isEmpty) {
          return '/signin';
        } else {
          return null; // return "null" to display the intended route without redirecting
        }
      },
      debugLogDiagnostics: true,
      errorBuilder: (context, state) => const Error404(),
      initialLocation: '/',
      routes: [
        GoRoute(
          name: "home_frame",
          path: "/",
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePageFrame()),
          redirect: (context, state) {
            if (userInfo.read("userData").isEmpty) {
              return '/signin';
            }
            return null; // return "null" to display the intended route without redirecting
          },
          routes: <RouteBase>[
            GoRoute(
              name: "home",
              path: 'home',
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              name: "explore",
              path: 'explore',
              builder: (context, state) => const ExplorePage(),
            ),
            GoRoute(
              name: "notifications",
              path: 'notifications',
              builder: (context, state) => const ExplorePage(),
            ),
            GoRoute(
              name: "profile",
              path: 'profile',
              builder: (context, state) => const ExplorePage(),
            ),
          ],
        ),
        GoRoute(
          name: "signin",
          path: "/signin",
          pageBuilder: (context, state) =>
              NoTransitionPage(child: Signin(session: session)),
        ),
        GoRoute(
          name: "signup",
          path: "/signup",
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: Signup()),
        ),
        GoRoute(
          name: "explore",
          path: "/explore",
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: Signup()),
        ),
      ]);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    userInfo.writeIfNull("isDarkTheme", true);
    userInfo.writeIfNull("rememberMe", false);
    userInfo.writeIfNull("accountType", "");
    userInfo.writeIfNull("currentIndex", 0);
    userInfo.writeIfNull("tempRole", "");
    userInfo.writeIfNull("tempEmail", "");
    userInfo.writeIfNull("tempPassword", "");
    userInfo.writeIfNull("currentTab", 0);
    userInfo.writeIfNull("userData", {
      "role": "artist",
      "full_name": "Johnny Doe",
      "name": "john d doe",
      "username": "johnny_doe",
      "email": "johndoe@gmail.com",
    });
    final constantValues = Get.put(Constants());
    var color = constantValues.defaultColor;
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData(
        primarySwatch: MaterialColor(0xFF4CAF50, color),
        colorScheme: ColorScheme.fromSeed(
            brightness: userInfo.read("isDarkTheme")
                ? Brightness.dark
                : Brightness.light,
            seedColor: constantValues.primaryColor),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(
                bodyColor: userInfo.read("isDarkTheme")
                    ? constantValues.whiteColor
                    : constantValues.darkColor),
        brightness:
            userInfo.read("isDarkTheme") ? Brightness.dark : Brightness.light,
      )),
      child: MaterialAppWithTheme(
          context: context, router: router, constantValues: constantValues),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  MaterialAppWithTheme({
    super.key,
    required this.context,
    required GoRouter router,
    required this.constantValues,
  }) : _router = router;
  StreamController streamController = StreamController();
  BuildContext context;
  final GoRouter _router;
  final Constants constantValues;

  void redirectToSigninPage() {
    if (rootNavigatorKey.currentContext != null) {
      _router.goNamed("signin");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    if (rootNavigatorKey.currentContext != null) {
      session.startListener(
          context: context, streamController: streamController);
    } else {
      session.stopListener(
          context: context, streamController: streamController);
    }
    return ChangeNotifierProvider(
        create: (context) => CustomStateModel(),
        child: SessionManager(
          onSessionExpired: () {
            if (rootNavigatorKey.currentContext != null &&
                session.enableSigninPage) {
              userInfo.write("performerData", {});
              ScaffoldMessenger.of(rootNavigatorKey.currentContext!)
                  .showSnackBar(sessionExpiry);
              redirectToSigninPage();
            }
          },
          duration: const Duration(hours: 12),
          streamController: streamController,
          child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              scrollBehavior: MyCustomScrollBehavior(),
              routerConfig: _router,
              title: "HolyHarmony",
              theme: theme.getTheme()
              // ThemeData(
              //     colorScheme: ColorScheme.fromSeed(
              //         seedColor: constantValues.secondaryColor),
              //     useMaterial3: true,
              //     textTheme:
              //         GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              //             .apply(bodyColor: constantValues.secondaryColor)
              //     // .copyWith(
              //     //   bodyLarge: TextStyle(color: constantValues.bodyTextColor),
              //     //   bodyMedium: TextStyle(color: constantValues.bodyTextColor)
              //     // )
              //     ),
              ),
        ));
  }
}
