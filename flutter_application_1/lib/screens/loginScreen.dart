import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/screens/home.dart';


// ignore: camel_case_types
class loginPage extends StatefulWidget {
  static String value2 = 'Hello';

  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

// ignore: camel_case_types
class _loginPageState extends State<loginPage> {
  final myControler = TextEditingController();
  final myControler2 = TextEditingController();

  String value = '';
  String value1 = '';
  String errorMessage = '';
  String errorMessage2 = '';

  @override
  void initState() {
    super.initState();
    myControler.text = ('');
  }

  void OnSubmit(String _value) {
    setState(() {
      value1 = _value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(child: puraniBody()),
    );
  }

  Column puraniBody() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(padding: EdgeInsets.all(10)),
        const Text(
          'TutorialKart',
          style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(247, 7, 154, 239),
              fontWeight: FontWeight.w500),
        ),
        const Padding(padding: EdgeInsets.all(10)),
        const Text(
          'Sign in',
          style: TextStyle(fontSize: 20),
        ),
        const Padding(padding: EdgeInsets.all(8)),
        SizedBox(
          width: 350,
          child: TextField(
            controller: myControler,
            onChanged: (value) {
              // print("value========");
              // print(value);
              // print(!(value.contains('@')));
              if (value.isEmpty || !(value.contains('@'))) {
                setState(() {
                  errorMessage = 'Email should contain @';
                });
              } else {
                setState(() {
                  errorMessage = '';
                });
              }
            },
            onSubmitted: OnSubmit,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'User Name',
                errorText: errorMessage),
          ),
        ),
        const Padding(padding: EdgeInsets.all(8)),
        SizedBox(
          width: 350,
          child: TextField(
            controller: myControler2,
            obscureText: true,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  errorMessage2 = 'Please enter password';
                });
              } else if (value.length > 8) {
                setState(() {
                  errorMessage2 = 'Please enter password less than 8 digit';
                });
              } else {
                setState(() {
                  errorMessage2 = '';
                });
              }
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Password',
              errorText: errorMessage2,
            ),
          ),
        ),
        TextButton(
            onPressed: () {},
            child: const Text(
              'Forget Password',
            )),
        ElevatedButton(
          onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home(testValue: " ")),
                    (route) => false),
          style: ElevatedButton.styleFrom(minimumSize: const Size(350, 50)),
          child: const Text('Login'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Does not have account?'),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
        Card(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const [
                Text('Hello Peoples'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
