import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../data/library.dart';
import '../routing.dart';
import '../data/issuedPass.dart';
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
  late String uid;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    initializeUserData();
    getIssuedPasses();
  }

  Future<void> initializeUserData() async {
    final user = auth.currentUser;
    uid = user?.uid ?? "";

    try {
      final ds = await firestore.collection("users").doc(uid).get();
      setState(() {
        fAadhar = ds.data()?['adhar'].toString();
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> getIssuedPasses() async {
    if (is_issuedPassAdded) {
      return;
    }

    final user = auth.currentUser;
    if (user == null) {
      return;
    }

    final uid = user.uid;

    try {
      final querySnapshot = await firestore
          .collection("passes")
          .doc(uid)
          .collection(DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        final index = documentSnapshot['index'] as int;
        final passes = libraryInstance.allIssuedPasses;
        final found = passes.any((pass) => pass.passIndex == index);

        if (!found) {
          libraryInstance.addPass(passIndex: index, issueDate: DateTime.now());
        }
      }
    } catch (e) {
      print("Error fetching issued passes: $e");
    }

    setState(() {
      is_issuedPassAdded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser?.displayName ?? "";

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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16),
                        child: Text('Hi $user'),
                      ),
                      if (libraryInstance.allIssuedPasses.isNotEmpty)
                        Container(
                          height: 200,
                          child: QrImageView(
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
                                  RouteStateScope.of(context).go('/authors');
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
      ),
    );
  }
}
