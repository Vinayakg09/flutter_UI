import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/loginScreen.dart';
import 'package:flutter_application_1/utils/toast.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final form_feild = GlobalKey<FormState>();
  final myControler = TextEditingController();
  final myControler2 = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

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
        title: Text('Sign Up'),
      ),
      body: Column(children: [
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
          'Sign up',
          style: TextStyle(fontSize: 20),
        ),
        const Padding(padding: EdgeInsets.all(8)),
        Form(
          key: form_feild,
          child: Container(
            child: Column(children: [
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: myControler,
                  onChanged: (value) {
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
                  onFieldSubmitted: OnSubmit,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: 'User Name',
                      errorText: errorMessage),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Email';
                    }
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: myControler2,
                  obscureText: true,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        errorMessage2 = 'Please enter password';
                      });
                    } else if (value.length > 8) {
                      setState(() {
                        errorMessage2 =
                            'Please enter password less than 8 digit';
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Password";
                    }
                  },
                ),
              ),
            ]),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (form_feild.currentState!.validate()) {
              _auth
                  .createUserWithEmailAndPassword(
                      email: myControler.text.toString(),
                      password: myControler2.text.toString())
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => loginPage()),
                    (route) => false);
                setState(() {});
              }).onError((error, stackTrace) {
                toast().toastMessage(error.toString(), Colors.red);
              });
            }
          },
          style: ElevatedButton.styleFrom(minimumSize: const Size(350, 50)),
          child: const Text('Sign Up'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Already have account?'),
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => loginPage()),
                      (route) => false);
                },
                child: const Text(
                  'Login in',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ]),
    );
  }
}
