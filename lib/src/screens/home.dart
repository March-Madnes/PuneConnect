import 'package:flutter/material.dart';
import 'package:pune_connect/src/widgets/book_list.dart';

import '../data/library.dart';
import '../routing.dart';
import '../widgets/book_list.dart';

// class AuthorsScreen extends StatelessWidget {
//   final String title = 'Authors';

//   const AuthorsScreen({super.key});

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//         ),
//         body: AuthorList(
//           authors: libraryInstance.allAuthors,
//           onTap: (author) {
//             RouteStateScope.of(context).go('/author/${author.id}');
//           },
//         ),
//       );
// }

class HomeScreen extends StatelessWidget {
  final String title = 'Pune Connect';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BookList(
        books: libraryInstance.allBooks,
        onTap: (book) {
          RouteStateScope.of(context).go('/book/${book.id}');
        },
      )
  );  
}