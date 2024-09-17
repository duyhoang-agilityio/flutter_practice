import 'package:device_preview/device_preview.dart';
import 'package:fl_query/fl_query.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:practice_advance/global.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance/main.dart';
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

  Global.environment = 'prod';

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => Bazar(
        queryClient: queryClient,
      ),
    ),
  );
}
