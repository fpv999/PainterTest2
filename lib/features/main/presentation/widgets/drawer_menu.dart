import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: 30),
            _DrawerMenuItem(
              icon: Icons.bluetooth,
              title: 'Something',
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  _DrawerMenuItem({
    @required this.icon,
    @required this.title,
    @required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(icon),
                ),
                Text(title, style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 18)),
              ],
            ),
            Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}

