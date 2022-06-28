import 'dart:io';
import 'dart:ui';

import 'package:digikala/homePage.dart';
import 'package:digikala/voorood.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _log = '';
  bool? goNextPage;
  final TextEditingController _controllerFirstName =
      TextEditingController(text: "");

  final TextEditingController _controllerLastName =
      TextEditingController(text: "");

  final TextEditingController _controllerPhoneNumber =
      TextEditingController(text: "");

  final TextEditingController _controllerEmail =
      TextEditingController(text: "");

  final TextEditingController _controllerPassword =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/homepage.png"),
                    fit: BoxFit.cover)),
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                          hintText: 'Firstname',
                          iconColor: Colors.black),
                      controller: _controllerFirstName,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                          hintText: 'Lastname',
                          iconColor: Colors.black),
                      controller: _controllerLastName,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                          hintText: 'Password',
                          iconColor: Colors.black),
                      controller: _controllerPassword,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                          hintText: 'Phonenumber',
                          iconColor: Colors.black),
                      controller: _controllerPhoneNumber,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                          hintText: 'email',
                          iconColor: Colors.black),
                      controller: _controllerEmail,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        sendInfoToServer(
                            _controllerFirstName.text,
                            _controllerLastName.text,
                            _controllerPassword.text,
                            _controllerPhoneNumber.text,
                            _controllerEmail.text);
                        if (goNextPage == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      },
                      child: const Text('Sign in'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side:
                                        const BorderSide(color: Colors.black))),
                      ),
                    ),
                  ),
                  TextButton(
                    child: const Text('already have an account?'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Vorod(),
                        ),
                      );
                    },
                  ),
                  Text(
                    _log,
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  sendInfoToServer(String firstName, String lastName, String password,
      String phoneNumber, String email) async {
    String request =
        "Signup\n$firstName/$lastName/$password/$phoneNumber/$email\u0000";

    await Socket.connect("10.0.2.2", 8000).then((ServerSocket) {
      ServerSocket.write(request);
      ServerSocket.flush();
      ServerSocket.listen((response) {
        print(String.fromCharCodes(response));
        setState(() {
          _log += (checkedResponse(String.fromCharCodes(response)));
          print('this is $_log');
        });
      });
    });
  }

  String checkedResponse(String data) {
    switch (data) {
      case '[0]':
        goNextPage = false;
        return 'Please fill in all of the fields';
      case '[1]':
        goNextPage = true;
        return 'Saved successfuly';
    }
    return '';
  }
}
