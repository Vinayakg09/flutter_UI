import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/signupScreen.dart';
import 'package:flutter_application_1/utils/toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class loginPage extends StatefulWidget {
  static String value2 = 'Hello';

  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

// ignore: camel_case_types
class _loginPageState extends State<loginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;
  final form_feild = GlobalKey<FormState>();
  final myControler = TextEditingController();
  final myControler2 = TextEditingController();

  String value = '';
  String value1 = '';
  String errorMessage = '';
  String errorMessage2 = '';

  Future<void> googleSignIn() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      toast().toastMessage("Login Uncessfull", Colors.red);
      return;
    }
    GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("email", userCredential.user!.email.toString());
      debugPrint("++++++++++++++++++++");
      debugPrint(userCredential.user!.email.toString());
      toast().toastMessage("login successfull", Colors.green);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home(testValue: "")),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //backgroundColor: Colors.white,
          title: const Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
        // body: SingleChildScrollView(child: puraniBody()),
        body: puraniBody(),
      ),
    );
  }

  Widget puraniBody() {
    return Form(
      key: form_feild,
      child: Column(
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
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
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
                    errorMessage2 = 'Please enter password less than 8 digit';
                  });
                } else {
                  setState(() {
                    errorMessage2 = '';
                  });
                }
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
          Spacer(
            flex: 1,
          ),
          Material(
            elevation: 10,
            child: ElevatedButton(
              onPressed: () {
                if (form_feild.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  _auth
                      .signInWithEmailAndPassword(
                          email: myControler.text.toString(),
                          password: myControler2.text.toString())
                      .then((value) async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setString("email", myControler.text.toString());
                    toast().toastMessage("login successfull", Colors.green);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Home(testValue: "")),
                        (route) => false);
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    toast().toastMessage(error.toString(), Colors.red);
                    setState(() {
                      loading = false;
                    });
                  });
                }
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(350, 50),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: loading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    )
                  : Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forget Password',
                  )),
              SizedBox(
                width: 30,
              )
            ],
          ),
          Spacer(
            flex: 3,
          ),
          ElevatedButton.icon(
            onPressed: googleSignIn,
            icon: FaIcon(FontAwesomeIcons.google),
            label: Text('Sign in with google'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
          Text("OR",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Does not have account?'),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => signup()),
                        (route) => false);
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
