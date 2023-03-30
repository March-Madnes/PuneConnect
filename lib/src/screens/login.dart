import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pune_connect/src/widgets/round_button.dart';
import 'package:pune_connect/src/widgets/utils.dart';
import 'package:pune_connect/src/routing/route_state.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    auth
    .authStateChanges()
    .listen((User? user) {
      if (user != null) {
        routeState.go('/home');
      }
    });
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Login'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: 'email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    )),
                RoundButton(
                  isLoading: isLoading,
                  title: 'Login',
                  onTap: () async{
                    if (_formKey.currentState!.validate()) {
                      // print(emailController.text);
                      // print(passwordController.text);
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text.toString(),
                        ).then((value) {
                                routeState.go('/home');
                                return value;
                        });
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        if (e.code == 'user-not-found') {
                          Utils().toastMessage('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          Utils().toastMessage('Wrong password provided for that user.');
                        }
                      }
                    };
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('Dont Have an account?'),
                    TextButton(
                      onPressed: () {
                        routeState.go('/signin');
                      },
                      child: const Text('Sign Up'),
                    )
                  ],
                )
              ],
            )));
  }
}
