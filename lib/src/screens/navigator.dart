import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pune_connect/src/screens/login.dart';

import '../routing.dart';
import '../screens/sign_in.dart';
import '../widgets/fade_transition_page.dart';
import 'scaffold.dart';

/// Builds the top-level navigator for the app. The pages to display are based
/// on the `routeState` that was parsed by the TemplateRouteParser.
class PuneConnectNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const PuneConnectNavigator({
    required this.navigatorKey,
    super.key,
  });

  @override
  State<PuneConnectNavigator> createState() => _PuneConnectNavigatorState();
}

class _PuneConnectNavigatorState extends State<PuneConnectNavigator> {
  // final _signInKey = const ValueKey('Sign in');
  final _scaffoldKey = const ValueKey('App scaffold');
  final _bookDetailsKey = const ValueKey('Book details screen');
  final _authorDetailsKey = const ValueKey('Author details screen');
  final _passDetailsKey = const ValueKey('Pass details screen');

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, dynamic result) {
        routeState.go('/home');
        return route.didPop(result);
      },
      pages: [
        if (routeState.route.pathTemplate == '/signin')
          FadeTransitionPage<void>(
            key: _scaffoldKey,
            child: const SignupScreen(),
        )
        else if (routeState.route.pathTemplate == '/login')
          FadeTransitionPage<void>(
            key: _scaffoldKey,
            child: const LoginScreen(),
        )
        else ...[
          // Display the app
          FadeTransitionPage<void>(
            key: _scaffoldKey,
            child: const PuneConnectScaffold(),
          ),
          // Add an additional page to the stack if the user is viewing a book
          // or an author
          // if (selectedBook != null)
          //   MaterialPage<void>(
          //     key: _bookDetailsKey,
          //     child: BookDetailsScreen(
          //       book: selectedBook,
          //     ),
          //   )
          // else if (selectedAuthor != null)
          //   MaterialPage<void>(
          //     key: _authorDetailsKey,
          //     child: AuthorDetailsScreen(
          //       author: selectedAuthor,
          //     ),
          //   )
          // if (selectedPass != null)
          //   MaterialPage<void>(
          //     key: _passDetailsKey,
          //     child: PassDetailsScreen(
          //       pass: selectedPass,
          //     ),
          //   ),
        ],
      ],
    );
  }
}
