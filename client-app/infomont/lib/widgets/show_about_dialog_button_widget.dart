import 'package:flutter/material.dart';

import 'package:package_info/package_info.dart';

class ShowAboutDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('About ...'),
      onPressed: () async {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        showAboutDialog(
          context: context,
          applicationIcon: Ink(
            width: 50.0,
            height: 50.0,
            decoration: const ShapeDecoration(
              color: Colors.black,
              shape: CircleBorder(),
            ),
            child: Icon(
              Icons.directions_walk,
              color: Color(0xFF445B18),
              size: 40,
            ),
          ),
          applicationName: packageInfo.appName,
          applicationVersion: packageInfo.version,
          applicationLegalese: '©2020 InfoMont',
        );
      },
    );
  }
}
