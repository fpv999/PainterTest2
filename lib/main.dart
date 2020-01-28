import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:logging/logging.dart' as log;

import 'package:PainterTest2/features/main/presentation/pages/main_page.dart';

void main() async {
  log.Logger.root.level = log.Level.SEVERE;
  //log.Logger.root.level = log.Level.ALL;
  log.hierarchicalLoggingEnabled = true;

  log.Logger.root.onRecord.listen((log.LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: [${rec.loggerName}] ${rec.message}');
  });

  BlocSupervisor.delegate = _TraceBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());

  
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Painter Test 2',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              switch (settings.name) {
                default:
                  return MainPage();
              }
            });
      },
      home: MainPage(),
    );
  }
}

class _TraceBlocDelegate extends BlocDelegate {
  final log.Logger _logger = log.Logger('bloc-trace');

  _TraceBlocDelegate() {
    //_logger.level = log.Level.ALL;
    _logger.level = log.Level.OFF;
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logger.info("  +<bloc><tr>: $transition");
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    _logger.info("  +<bloc><ev>: $event");
  }
}
