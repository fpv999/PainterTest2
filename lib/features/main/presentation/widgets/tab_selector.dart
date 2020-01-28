import 'package:flutter/material.dart';
import 'package:PainterTest2/core/models/app_tab.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tbColor = Theme.of(context).primaryColor;
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        switch (tab) {
          case AppTab.activity:
            return BottomNavigationBarItem(
              backgroundColor: tbColor,
              icon: Icon(Icons.home),
              title: Text('Chart'),
            );

          case AppTab.home:
            return BottomNavigationBarItem(
              backgroundColor: tbColor,
              icon: Icon(Icons.home),
              title: Text('Page 2'),
            );

          case AppTab.history:
            return BottomNavigationBarItem(
              backgroundColor: tbColor,
              icon: Icon(Icons.home),
              title: Text('Page 3'),
            );


          case AppTab.profile:
          default:
            return BottomNavigationBarItem(
              backgroundColor: tbColor,
              icon: Icon(Icons.home),
              title: Text('Page 4'),
            );
        }
      }).toList(),
    );
  }
}
