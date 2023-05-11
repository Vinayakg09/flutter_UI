import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';

class Reedem extends StatefulWidget {
  const Reedem({super.key});

  @override
  State<Reedem> createState() => _ReedemState();
}

class _ReedemState extends State<Reedem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reedem'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                Text('Sorry! Offer Expire'),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home(testValue: "")),
                          (route) => false);
                    },
                    child: Text('Back'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
