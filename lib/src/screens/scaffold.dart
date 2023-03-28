// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';

import '../routing.dart';
import 'scaffold_body.dart';

class PuneConnectScaffold extends StatelessWidget {
  const PuneConnectScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: const PuneConnectScaffoldBody(),
        onDestinationSelected: (idx) {
          if (idx == 0) routeState.go('/home');
          if (idx == 1) routeState.go('/authors');
          if (idx == 2) routeState.go('/settings');
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Home',
            icon: Icons.home,
          ),
          AdaptiveScaffoldDestination(
            title: 'Book Pass',
            icon: Icons.add_box,
          ),
          AdaptiveScaffoldDestination(
            title: 'Settings',
            icon: Icons.admin_panel_settings,
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    if (pathTemplate.startsWith('/home')) return 0;
    if (pathTemplate == '/authors') return 1;
    if (pathTemplate == '/settings') return 2;
    return 0;
  }
}
