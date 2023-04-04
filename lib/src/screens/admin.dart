
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser!.displayName;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        
        child:
        ListView(
          
        children:
        <Widget>[
              const SizedBox(
                height: 50,
              ),
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 5.0,
                percent: 0.1,
                center: Image.asset("assets/images/users.png",height: 150, width: 150,),
                backgroundColor: Colors.white10,
                progressColor: Colors.deepPurpleAccent,
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      user.toString(),
                      style: TextStyle(fontSize: 35, fontWeight:FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      '20 @eco_points',
                      style: TextStyle(fontSize: 18, fontWeight:FontWeight.w300),
                    ),
                  ),
                  TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                print('object');
              },
              child: Text('View History'),
            ),
                ],
              ),
        ]
      ),
      ),
    );
  }
}
