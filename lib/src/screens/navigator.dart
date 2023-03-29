// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pune_connect/src/screens/login.dart';

// import '../auth.dart';
import '../data.dart';
import '../routing.dart';
import '../screens/sign_in.dart';
import '../widgets/fade_transition_page.dart';
import 'author_details.dart';
import 'book_details.dart';
import 'pass_details.dart';
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
    // final authState = PuneConnectAuthScope.of(context);
    // final pathTemplate = routeState.route.pathTemplate;

    // Book? selectedBook;
    // if (pathTemplate == '/book/:bookId') {
    //   selectedBook = libraryInstance.allBooks.firstWhereOrNull(
    //       (b) => b.id.toString() == routeState.route.parameters['bookId']);
    // }

    // Author? selectedAuthor;
    // if (pathTemplate == '/author/:authorId') {
    //   selectedAuthor = libraryInstance.allAuthors.firstWhereOrNull(
    //       (b) => b.id.toString() == routeState.route.parameters['authorId']);
    // }

    // Pass? selectedPass;
    // if (pathTemplate == '/pass/:passId') {
    //   selectedPass = libraryInstance.allPasses.firstWhereOrNull(
    //       (b) => b.passIndex.toString() == routeState.route.parameters['passId']);
    // }

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, dynamic result) {
        // When a page that is stacked on top of the scaffold is popped, display
        // the /books or /authors tab in PuneConnectScaffold.
        // if (route.settings is Page &&
        //     (route.settings as Page).key == _bookDetailsKey) {
        //   routeState.go('/home');
        // }

        // if (route.settings is Page &&
        //     (route.settings as Page).key == _authorDetailsKey) {
        //   routeState.go('/authors');
        // }

        // if (route.settings is Page &&
        //     (route.settings as Page).key == _passDetailsKey) {
        //   routeState.go('/home');
        // }
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
