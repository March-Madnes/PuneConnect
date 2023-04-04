import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../data/library.dart';
import '../routing.dart';
import '../widgets/issued_pass.dart';

class HomeScreen extends StatefulWidget {
  final String title = 'Pune Connect';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String title = 'Pune Connect';
  bool is_issuedPassAdded = false;

  dynamic fAadhar;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getIssuedPasses() async {
    if (is_issuedPassAdded) {
      return;
    }
    Library.clearIssuedPass();

    QuerySnapshot querySnapshot = await firestore
        .collection("passes")
        .doc(uid)
        .collection(DateFormat('yyyy-MM-dd').format(DateTime.now()))
        .get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      int index = documentSnapshot['index'] as int;
      libraryInstance.addPass(passIndex: index, issueDate: DateTime.now());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = auth.currentUser!.displayName;
    final uid = auth.currentUser?.uid;

    getData() async {
      await firestore.collection("users").doc(uid).get().then((ds) {
        setState(() {
          fAadhar = ds.data()?['adhar'];
        });
      });
    }

    if (!is_issuedPassAdded) {
      getIssuedPasses();
      setState(() {
        is_issuedPassAdded = true;
      });
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              tooltip: 'Open shopping cart',
              onPressed: () async {
                await auth.signOut();
                RouteStateScope.of(context).go('/login');
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ignore: prefer_const_constructors
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16),
                          child: Text('Hii $user'),
                        ),
                        if (libraryInstance.allIssuedPasses.isNotEmpty)
                          Container(
                            height: 200,
                            child: QrImage(
                              data: fAadhar.toString(),
                              version: QrVersions.auto,
                              size: 200.0,
                            ),
                          ),
                        if (libraryInstance.allIssuedPasses.isEmpty)
                          Column(
                            children: [
                              const Text("No Passes Issued for the day"),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: FilledButton(
                                  onPressed: () {
                                    RouteStateScope.of(context).go('/book');
                                  },
                                  child: const Text("Issue Pass"),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: IssuedPassList(
                passes: libraryInstance.allIssuedPasses,
                onTap: (issuedPass) {
                  print("Hello");
                },
              ),
            ),
          ],
        ));
  }
}
