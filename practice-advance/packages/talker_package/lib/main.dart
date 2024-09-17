import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

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

class BlocLogger {
  static void init() {
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
  }
}