import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;

class UserDetail {
  var name;
  var email;
  var photoUrl;
  var emailVerified;
  var uid;
  var aadharNumber;

  Future<void> fetchUserDetails() async {
    final user = auth.currentUser;
    if (user != null) {
      name = user.displayName;
      email = user.email;
      photoUrl = user.photoURL;
      emailVerified = user.emailVerified;
      uid = user.uid;

      final docRef = db.collection("users").doc('${uid}');
      await docRef.get().then(
        (doc) {
          aadharNumber =(doc.data() as Map<String, dynamic>)['adhar'];
        },
        // ignore: avoid_print
        onError: (e) => print("Error getting document: $e"),
      );
    }
    
  }

  UserDetail()
  {
    fetchUserDetails();
  }
}

UserDetail user =user;
