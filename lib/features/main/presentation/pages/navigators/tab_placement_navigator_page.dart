import 'package:flutter/material.dart';
import 'package:PainterTest2/app_keys.dart';
import 'package:PainterTest2/core/models/app_tab.dart';
import 'package:PainterTest2/features/placement/presentation/pages/placement_page.dart';

class TabPlacementNavigatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: AppKeys.navigatorKeys[AppTab.activity],
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) {
                switch (settings.name) {
                  default:
                    return PlacementPage();
                }
              }
          );
        }
    );
  }
}


