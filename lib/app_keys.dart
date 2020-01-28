import 'package:flutter/material.dart';
import 'package:PainterTest2/core/models/app_tab.dart';

class AppKeys {
  static final Map<AppTab, GlobalKey<NavigatorState>> navigatorKeys = {
    AppTab.home     : GlobalKey<NavigatorState>(),
    AppTab.history  : GlobalKey<NavigatorState>(),
    AppTab.activity : GlobalKey<NavigatorState>(),
    AppTab.profile  : GlobalKey<NavigatorState>()
  };
}
