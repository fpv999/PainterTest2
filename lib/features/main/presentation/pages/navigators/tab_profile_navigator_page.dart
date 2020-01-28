import 'package:flutter/material.dart';
import 'package:PainterTest2/app_keys.dart';
import 'package:PainterTest2/core/models/app_tab.dart';
import 'package:PainterTest2/features/profile/presentation/pages/profile_page.dart';

class TabProfileNavigatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: AppKeys.navigatorKeys[AppTab.profile],
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) {
                switch (settings.name) {
                  default:
                    return ProfilePage();
                }
              }
          );
        }
    );
  }
}
