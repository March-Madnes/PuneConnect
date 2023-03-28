// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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
            // TextButton(
            //   child: const Text('View author (Push)'),
            //   onPressed: () {
            //     Navigator.of(context).push<void>(
            //       MaterialPageRoute<void>(
            //         builder: (context) =>
            //             AuthorDetailsScreen(author: pass!.author),
            //       ),
            //     );
            //   },
            // ),
            // Link(
            //   uri: Uri.parse('/author/${pass!.author.id}'),
            //   builder: (context, followLink) => TextButton(
            //     onPressed: followLink,
            //     child: const Text('View author (Link)'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
