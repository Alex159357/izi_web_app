
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:izi_web/ui/theme/theme_switcher/theme_notifier.dart';
import 'package:provider/provider.dart';

Widget themeSwitcher() {
  return Container(
    child: Consumer<ThemeNotifier>(
      builder: (context, notifier, child) => Container(
        child: SwitchListTile(
          title: Text("Dark Mode"),
          onChanged: (value) {
            notifier.toggleTheme();
          },
          value: notifier.darkTheme,
        ),
      ),
    ),
  );
}
