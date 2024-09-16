import 'package:device_preview/device_preview.dart';
import 'package:fl_query/fl_query.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance/router.dart';
import 'package:practice_advance_design/foundations/themes/theme.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';

final talker = Talker(
  settings: TalkerSettings(
    colors: {
      TalkerLogType.httpResponse: AnsiPen()..magenta(),
      TalkerLogType.error: AnsiPen()..red(),
      TalkerLogType.info: AnsiPen()..yellow(),
    },
    titles: {
      TalkerLogType.exception: 'EXCEPTION',
      TalkerLogType.error: 'ERROR',
      TalkerLogType.info: 'INFO',
      TalkerLogType.debug: 'DEBUG',
      TalkerLogType.blocCreate: 'BLoC',
    },
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await initApp();

  // Setup QueryClient for fl_query (cachedQuery)
  final queryClient = QueryClient(
    staleDuration: const Duration(minutes: 5),
    cacheDuration: const Duration(hours: 1),
  );

  Bloc.observer = TalkerBlocObserver(
    settings: const TalkerBlocLoggerSettings(
      enabled: true,
      printChanges: true,
      printClosings: true,
      printCreations: true,
      printEvents: true,
      printTransitions: true,
      printEventFullData: false,
      printStateFullData: false,
    ),
  );

  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]);

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => Bazar(
        queryClient: queryClient,
      ),
    ),
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
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(360, 890),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => MaterialApp.router(
          themeMode: ThemeMode.light,
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          routerConfig: router,
          title: 'Bazar App',
        ),
      );
}
