import 'package:device_preview/device_preview.dart';
import 'package:fl_query/fl_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practice_advance/router.dart';
import 'package:practice_advance_design/foundations/themes/theme.dart';

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
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          routerConfig: router,
          title: 'Bazar App',
        ),
      );
}
