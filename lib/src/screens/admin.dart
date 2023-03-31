
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        title: Text("Profile"),
      ),
      body: Center(
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Padding(padding: EdgeInsets.all(80),
        //       child: Image.asset("assets/images/users.png", fit: BoxFit.cover),
        //     ),
        //     Text(
        //       "Name: $user",
        //       style: TextStyle(
        //         fontSize: 20,
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 20,
        //     ),
        //     Text(
        //       "Email: ${auth.currentUser!.email}",
        //       style: TextStyle(
        //         fontSize: 16,
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 20,
        //     ),
        //     const Text(
        //       "Eco Points: 0",
        //       style: TextStyle(
        //         fontSize: 16,
        //       ),
        //     ),
            
        //   ],
        // ),
        
        child:
        ListView(
          
        children:
        <Widget>[
              const SizedBox(
                height: 50,
              ),
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: 0.8,
                center: Image.asset("assets/images/users.png",height: 100, width: 200,),
                // center: const Icon(
                //   Icons.person_pin,
                //   size: 50.0,
                //   color: Colors.blue,
                // ),
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Name: $user",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Email: ${auth.currentUser!.email}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Eco Points: 0",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Get a 10% discount on your next purchase with 100 eco points.",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
        ]
      ),
      ),
    );
  }
}
