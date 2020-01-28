import 'package:flutter/material.dart';
import 'package:PainterTest2/app_keys.dart';
import 'package:PainterTest2/core/models/app_tab.dart';
import 'package:PainterTest2/features/history/presentation/pages/history_page.dart';

class TabHistoryNavigatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: AppKeys.navigatorKeys[AppTab.history],
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) {
                switch (settings.name) {
                  default:
                    return HistoryPage();
                }
              }
          );
        }
    );
  }
}