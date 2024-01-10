import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'logo_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: LogoWidget(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('JS Guru'),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              context.go('/');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.photo,
            ),
            title: const Text('Gallery'),
            onTap: () {
              context.go('/photos');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
