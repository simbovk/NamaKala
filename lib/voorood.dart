import 'package:flutter/material.dart';

import 'homePage.dart';

class Vorod extends StatelessWidget {
  const Vorod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('LOGIN' , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),),
                const SizedBox(height: 50),
                const TextField(
                   decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    hintText: 'Phonenumber',
                    iconColor: Color.fromARGB(255, 78, 255, 223))
                ),
                const SizedBox(height: 40),
                const TextField(
                  obscureText: true,
                   decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    hintText: 'Password',
                    iconColor: Color.fromARGB(255, 78, 175, 255))
                ),
                const SizedBox(height: 50,),
                SizedBox(
                  height: 30,
                  width: 100,
                  child: ElevatedButton(onPressed:(){
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  HomePage(),
                    ),
                  );
                },
                 child: const Text('Login')
                )
               )
              ],
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/login.PNG"),
              fit: BoxFit.cover
              ),
            ),
          ),
        ),
      ),
    );
  }
}
