import 'package:debate/models/user/user.dart';
import 'package:debate/pages/wrapper.dart';
import 'package:debate/services/Login/authentication.dart';
import 'package:debate/shared/Custome_Widgets/loading/loading.dart';
import 'package:debate/shared/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();

  // GetPermissions().getStoragePermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: summaryColour,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: summaryColour));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // LocalDataSet().deleteLocalData();
          // LocalDataSet().writeStates('');
          // AuthService().signOut();
          // AuthService().googleLogout();
          // AuthService().deleteGoogleAccount();

          return StreamProvider<UserObject?>.value(
              value: AuthService().user,
              initialData: null,
              child: MaterialApp(
                // builder: (context, child) {
                //   return ScrollConfiguration(
                //     // ignore: deprecated_member_use
                //     behavior: new ScrollBehavior()
                //       ..buildOverscrollIndicator(context, null,
                //           ScrollableDetails(direction: AxisDirection.down, controller: ScrollController())),
                //     child: child,
                //   );
                // },
                theme: ThemeData(
                    // bottomNavigationBarTheme: BottomNavigationBarThemeData(),
                    bottomSheetTheme: const BottomSheetThemeData(
                  modalBackgroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                )),
                debugShowCheckedModeBanner: false,
                home: const Wrapper(),
              ));
        } else {
          return MaterialApp(
              theme: ThemeData(
                  bottomSheetTheme: const BottomSheetThemeData(
                modalBackgroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
              )),
              debugShowCheckedModeBanner: false,
              home: Loading());
        }
      },
    );
  }
}
