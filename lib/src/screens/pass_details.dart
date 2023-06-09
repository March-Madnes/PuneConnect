import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
    print(response.error);
    print(response.message);
    print("why");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  CollectionReference passes = FirebaseFirestore.instance.collection('passes');

  Future<void> addPass() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid;

    // update eco points
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(uid).update({'eco_points': FieldValue.increment(30)});
    
    var data = {
      'index': widget.pass!.passIndex,
      'full_name': auth.currentUser?.displayName,
      'price': widget.pass!.price,
      'pass_type': widget.pass!.title,
      'time': DateTime.now(),
    };
    return passes.doc(uid).collection(DateFormat('yyyy-MM-dd').format(DateTime.now())).doc().set(data)
    .onError((e, _) => print("Error writing document: $e"));

    
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

    Map<String, String> passDetails ={
    'passIndex' : widget.pass!.passIndex.toString(),
    'passTitle' : widget.pass!.title,
    'userName' : auth.currentUser!.displayName ?? "",
    'passPrice' : widget.pass!.price.toString(),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pass!.title),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.pass!.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Price: ₹${passDetails['passPrice']}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Padding(padding: EdgeInsets.all(20.0),
            child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, \n quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton(
              onPressed: () {
                var options = {
                  'key': "rzp_test_4Q6YObDL0hgfUu",
                  // amount will be multiple of 100
                  'amount': int.parse(passDetails['passPrice']!)*100, //So its pay 500
                  'name': passDetails['username'],
                  'description': passDetails['passTitle'],
                  'timeout': 300, // in seconds
                  // 'prefill': {
                    // 'contact': '8767272564',
                    // 'email': 'sahilkamate03@gmail.com'
                  // }
                };
                _razorpay.open(options);
              },
              child: const Text("Book Now"),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                var options = {
                  'key': "rzp_test_4Q6YObDL0hgfUu",
                  // amount will be multiple of 100
                  'amount': int.parse(passDetails['passPrice']!)*100, //So its pay 500
                  'name': passDetails['username'],
                  'description': passDetails['passTitle'],
                  'timeout': 300, // in seconds
                  // 'prefill': {
                    // 'contact': '8767272564',
                    // 'email': 'sahilkamate03@gmail.com'
                  // }
                };
                _razorpay.open(options);
              },
              child: Text('Book using EcoPoints'),
            )
          ],
        ),
      ),
    );
  }
}
