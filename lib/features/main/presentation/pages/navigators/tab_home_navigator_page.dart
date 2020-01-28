import 'package:flutter/material.dart';
import 'package:PainterTest2/app_keys.dart';
import 'package:PainterTest2/core/models/app_tab.dart';
import 'package:PainterTest2/features/home/presentation/pages/home_page.dart';

class TabHomeNavigatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: AppKeys.navigatorKeys[AppTab.home],
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) {
                switch (settings.name) {
                  default:
                    return HomePage();
                }
              }
          );
        }
    );
  }
}