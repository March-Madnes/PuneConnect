// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data.dart';

class PassDetailsScreen extends StatefulWidget {
  final Pass? pass;

  PassDetailsScreen({super.key, this.pass});

  @override
  State<PassDetailsScreen> createState() => _PassDetailsScreenState();
}

class _PassDetailsScreenState extends State<PassDetailsScreen> {
  late var _razorpay;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done");
    addPass();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  CollectionReference passes = FirebaseFirestore.instance.collection('passes');

  Future<void> addPass() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid;
    var data = {
      'full_name': auth.currentUser?.displayName,
      'price': widget.pass!.price,
      'pass_type': widget.pass!.title,
    };
    return passes.doc(uid).set(data, SetOptions(merge: true))
    .onError((e, _) => print("Error writing document: $e"));
    // Call the user's CollectionReference to add a new user
    // return passes
    //     .add({'full_name': 'Sahil Kamate', 'age': 19, 'price': 40})
    //     .then((value) => print("User Pass Added"))
    //     .catchError((error) => print("Failed to add user pass: $error"));
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid;
    if (widget.pass == null) {
      return const Scaffold(
        body: Center(
          child: Text('No pass found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pass!.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              widget.pass!.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              widget.pass!.price.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text('hello pass details'),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                var options = {
                  'key': "rzp_test_4Q6YObDL0hgfUu",
                  // amount will be multiple of 100
                  'amount': '100', //So its pay 500
                  'name': 'PMPML Pass',
                  'description': 'Demo',
                  'timeout': 300, // in seconds
                  'prefill': {
                    'contact': '8767272564',
                    'email': 'sahilkamate03@gmail.com'
                  }
                };
                _razorpay.open(options);
              },
              child: Text('TextButton'),
            )

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
