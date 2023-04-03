import 'package:flutter/material.dart';

import '../data/library.dart';
import '../routing.dart';
import '../widgets/pass_list.dart';

class BookPassScreen extends StatelessWidget {
  final String title = 'Book Pass';

  const BookPassScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: PassList(
          passes: libraryInstance.allPasses,
          onTap: (pass) {
            RouteStateScope.of(context).go('/pass/${pass.passIndex}');
          },
        ),
      );
}
