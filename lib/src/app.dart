// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:pune_connect/src/screens/home.dart';

// import 'auth.dart';
import 'routing.dart';
import 'screens/navigator.dart';

class PuneConnect extends StatefulWidget {
  const PuneConnect({super.key});

  @override
  State<PuneConnect> createState() => _PuneConnectState();
}

class _PuneConnectState extends State<PuneConnect> {
  
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final RouteState _routeState;
  late final SimpleRouterDelegate _routerDelegate;
  late final TemplateRouteParser _routeParser;

  @override
  void initState() {
    /// Configure the parser with all of the app's allowed path templates.
    _routeParser = TemplateRouteParser(
      allowedPaths: [
        '/signin',
        '/login',
        '/authors',
        '/home',
        '/settings',
        '/books/new',
        '/books/all',
        '/books/popular',
        '/book/:bookId',
        '/pass/:passId',
        '/issuedPass/:issuedPassId'
        '/author/:authorId',
      ],
      initialRoute: '/signin',
    );

    _routeState = RouteState(_routeParser);

    _routerDelegate = SimpleRouterDelegate(
      routeState: _routeState,
      navigatorKey: _navigatorKey,
      builder: (context) => PuneConnectNavigator(
        navigatorKey: _navigatorKey,
      ),
    );

    // Listen for when the user logs out and display the signin screen.
    // _auth.addListener(_handleAuthStateChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) => RouteStateScope(
        notifier: _routeState,
        // child: PuneConnectAuthScope(
        //   notifier: _auth,
          child: MaterialApp.router(
            routerDelegate: _routerDelegate,
            routeInformationParser: _routeParser,
            themeMode: ThemeMode.dark,
            // Revert back to pre-Flutter-2.5 transition behaior:
            // https://github.com/flutter/flutter/issues/82053
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
                },
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.deepPurple,
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
                },
              ),
            ),
          ),
        // ),
      );

  // Future<ParsedRoute> _guard(ParsedRoute from) async {
  //   // final signedIn = _auth.signedIn;
  //   final signInRoute = ParsedRoute('/signin', '/signin', {}, {});

  //   // Go to /signin if the user is not signed in
  //   if (!signedIn && from != signInRoute) {
  //     return signInRoute;
  //   }
  //   // Go to /home if the user is signed in and tries to go to /signin.
  //   else if (signedIn && from == signInRoute) {
  //     return ParsedRoute('/home', '/home', {}, {});
  //   }
  //   return from;
  // }

  // void _handleAuthStateChanged() {
  //   if (!_auth.signedIn) {
  //     _routeState.go('/signin');
  //   }
  // }

  @override
  void dispose() {
    // _auth.removeListener(_handleAuthStateChanged);
    _routeState.dispose();
    _routerDelegate.dispose();
    super.dispose();
  }
}
