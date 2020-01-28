import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PainterTest2/app_keys.dart';
import 'package:PainterTest2/core/models/app_tab.dart';
import 'package:PainterTest2/features/main/presentation/bloc/bloc.dart';
import 'package:PainterTest2/features/main/presentation/pages/navigators/tab_placement_navigator_page.dart';
import 'package:PainterTest2/features/main/presentation/pages/navigators/tab_history_navigator_page.dart';
import 'package:PainterTest2/features/main/presentation/pages/navigators/tab_home_navigator_page.dart';
import 'package:PainterTest2/features/main/presentation/pages/navigators/tab_profile_navigator_page.dart';
import 'package:PainterTest2/features/main/presentation/widgets/drawer_menu.dart';
import 'package:PainterTest2/features/main/presentation/widgets/tab_selector.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Map<AppTab, Widget> _tabPages = {
    AppTab.home: TabHomeNavigatorPage(),
    AppTab.history: TabHistoryNavigatorPage(),
    AppTab.activity: TabPlacementNavigatorPage(),
    AppTab.profile: TabProfileNavigatorPage(),
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        drawer: Drawer(
          child: DrawerMenu(),
        ),
        appBar: AppBar(
          title: Text('PaintTest2'),
        ),
        body: BlocProvider<MainBloc>(
          create: (context) => MainBloc(),
          child: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
            return WillPopScope(
              onWillPop: () async {
                return !await AppKeys.navigatorKeys[state.tab].currentState
                    .maybePop();
              },
              child: Scaffold(
                body: Stack(
                  children: <Widget>[
                    _tabBody(AppTab.home, state.tab),
                    _tabBody(AppTab.history, state.tab),
                    _tabBody(AppTab.activity, state.tab),
                    _tabBody(AppTab.profile, state.tab),
                  ],
                ),
                bottomNavigationBar: TabSelector(
                  activeTab: state.tab,
                  onTabSelected: (tab) => BlocProvider.of<MainBloc>(context)
                      .add(MainEventChangeTab(newTab: tab)),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _tabBody(AppTab tab, AppTab currentTab) {
    return Visibility(
      visible: currentTab == tab,
      child: _tabPages[tab],
      maintainState: false,
    );
  }
}
