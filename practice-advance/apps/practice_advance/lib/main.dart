import 'package:device_preview/device_preview.dart';
import 'package:fl_query/fl_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practice_advance/global.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance/router.dart';
import 'package:practice_advance_design/foundations/themes/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:talker_package/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await setupLocator();

  // Setup QueryClient for fl_query (cachedQuery)
  final queryClient = QueryClient(
    staleDuration: const Duration(minutes: 5),
    cacheDuration: const Duration(hours: 1),
  );

  // Initialize the Bloc observer
  BlocLogger.init();

  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]);

  Global.environment = 'dev';

  runApp(
    Bazar(
      queryClient: queryClient,
    ),
    // DevicePreview(
    //   builder: (context) => Bazar(
    //     queryClient: queryClient,
    //   ),
    // ),
  );
}

/// The main app.
class Bazar extends StatelessWidget {
  /// Constructs a [Bazar]
  const Bazar({
    super.key,
    required this.queryClient,
  });

  final QueryClient queryClient;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
          375, 812), // Adjust this to your design size (e.g., iPhone 12)
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          MaterialApp.router(
            themeMode: ThemeMode.light,
            theme: lightTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            routerConfig: router,
            title: 'Bazar App',
          ),
          breakpoints: const [
            ResponsiveBreakpoint.autoScale(400, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
          ],
          background: Container(color: Colors.grey[200]),
        );
      },
    );
  }
}
