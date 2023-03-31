// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:firebase_storage/firebase_storage.dart';

import 'issuedPass.dart';
import 'pass.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
final uid = auth.currentUser?.uid;

CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('passes');

Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
}





Library libraryInstance = Library()
..addPass(passIndex: 0, issueDate: DateTime(2023, 10, 13));

// ..addBook(
//     title: 'Left Hand of Darkness',
//     authorName: 'Ursula K. Le Guin',
//     isPopular: true,
//     isNew: true,
//   )
// ..addBook(
//     title: 'Too Like the Lightning',
//     authorName: 'Ada Palmer',
//     isPopular: false,
//     isNew: true,
//   )
// ..addBook(
//     title: 'Kindred',
//     authorName: 'Octavia E. Butler',
//     isPopular: true,
//     isNew: false,
//   )
// ..addBook(
//     title: 'The Lathe of Heaven',
//     authorName: 'Ursula K. Le Guin',
//     isPopular: false,
//     isNew: false,
//   );

class Library {
  final List<IssuedPass> allIssuedPasses = [];
  final List<Pass> allPasses = [
    Pass(0, 'Daily Pass', 50, const Icon(Icons.abc_outlined)),
    Pass(1, 'Women Pass', 40, const Icon(Icons.girl)),
    Pass(2, 'Student Pass', 25, const Icon(Icons.person_2)),
    Pass(3, 'Senior Citizen Pass', 40, const Icon(Icons.person_3))
  ];
  // constructor
  Library() {
    // while(true){
    //   allIssuedPasses.add(IssuedPass(
    //       allIssuedPasses.length,
    //       i,
    //       allPasses[i].title,
    //       DateTime(2023, 10, 13),
    //       allPasses[i].price,
    //       allPasses[i].passIcon));
    // }
  }

  void addPass({
    required int passIndex,
    required DateTime issueDate,
  }) {
    var issuedPass = IssuedPass(
        allIssuedPasses.length,
        passIndex,
        allPasses[passIndex].title,
        issueDate,
        allPasses[passIndex].price,
        allPasses[passIndex].passIcon);
    allIssuedPasses.add(issuedPass);
  }

//   void addBook({
//     required String title,
//     required String authorName,
//     required bool isPopular,
//     required bool isNew,
//   }) {
//     var author = allAuthors.firstWhere(
//       (author) => author.name == authorName,
//       orElse: () {
//         final value = Author(allAuthors.length, authorName);
//         allAuthors.add(value);
//         return value;
//       },
//     );
//     var book = Book(allBooks.length, title, isPopular, isNew, author);

//     author.books.add(book);
//     allBooks.add(book);
//   }

//   List<Book> get popularBooks => [
//         ...allBooks.where((book) => book.isPopular),
//       ];

//   List<Book> get newBooks => [
//         ...allBooks.where((book) => book.isNew),
//       ];
}
