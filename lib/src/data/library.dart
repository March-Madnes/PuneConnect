import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'issuedPass.dart';
import 'pass.dart';

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

Library libraryInstance = Library();
  // ..addPass(passIndex: 1, issueDate: DateTime(2023, 11, 13));
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
    Pass(0, 'Pass: Daily', 50, const Icon(Icons.abc_outlined)),
    Pass(1, 'Pass: Women', 40, const Icon(Icons.abc_outlined)),
    Pass(2, 'Pass: Students', 25, const Icon(Icons.abc_outlined)),
    Pass(3, 'Pass: Senior Citizen', 40, const Icon(Icons.abc_outlined)),
    Pass(4, 'Tour: Aga Khan Palace', 25, const Icon(Icons.person_3)),
    Pass(5, 'Tour: Shanivar Wada', 20, const Icon(Icons.person_3))
  ];
  // constructor
  Library();

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


  void clearIssuedPass()
  {
    allIssuedPasses.clear();
  }
}
