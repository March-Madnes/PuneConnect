import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';

class IssuedPassDetailsScreen extends StatelessWidget {
  final IssuedPass? pass;

  const IssuedPassDetailsScreen({
    super.key,
    this.pass
  });

  @override
  Widget build(BuildContext context) {
    if (pass == null) {
      return const Scaffold(
        body: Center(
          child: Text('No pass found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(pass!.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              pass!.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              pass!.price.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              pass!.id.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              pass!.issueDate.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              pass!.issueDate.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
