import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_application_1/screens/Reedem.dart';
import 'package:flutter_application_1/screens/loginScreen.dart';

class Home extends StatefulWidget {
  final String testValue = '';
  const Home({super.key, required String testValue});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  Color _iconColor = Colors.lightBlueAccent;
  int tabIndex = 0;

  List<String> images = ['images/uber eats.jpeg', 'images/zara_offers.jpeg'];
  List<IconData> _icons = [
    Icons.card_giftcard,
    Icons.access_alarm_rounded,
    Icons.add_alert,
    Icons.add_reaction,
    Icons.boy_sharp,
    Icons.card_giftcard
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //bottomOpacity: 0.0,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        title: const Text('Partners',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
      ),
      endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => loginPage()),
                    ),
                child: const Text('Login')),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back')),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: body(),
      ),
      bottomNavigationBar: ConvexAppBar(
        activeColor: Colors.blue,
        backgroundColor: Colors.white,
        color: Colors.grey,
        items: [
          TabItem(
              icon: Icon(
                Icons.home,
                color: tabIndex == 0 ? Colors.white : Colors.blue,
              ),
              title: 'Home'),
          TabItem(
              icon: Icon(
                Icons.bed,
                color: tabIndex == 1 ? Colors.white : Colors.blue,
              ),
              title: 'Services'),
          TabItem(
              icon: Icon(
                Icons.handshake,
                color: tabIndex == 2 ? Colors.white : Colors.blue,
              ),
              title: 'Partners'),
          TabItem(
              icon: Icon(
                Icons.alarm,
                color: tabIndex == 3 ? Colors.white : Colors.blue,
              ),
              title: 'Activity'),
        ],
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
        },
      ),
    );
  }

  body() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          height: 50,
          width: 350,
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search partners',
              fillColor: Color.fromARGB(186, 227, 231, 233),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const Divider(
            height: 60,
            thickness: 15,
            color: Color.fromARGB(186, 227, 231, 233)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      width: 80.0,
                      child: IconButton(
                          icon: Icon(Icons.card_giftcard), onPressed: () {}),
                    ),
                    Container(
                      width: 80.0,
                      child: IconButton(
                        icon: Icon(Icons.access_alarm_rounded),
                        onPressed: () {},
                        tooltip: 'Alarm',
                      ),
                    ),
                    Container(
                      width: 80.0,
                      child: IconButton(
                          icon: Icon(Icons.add_alert),
                          onPressed: () {},
                          tooltip: 'Click me'),
                    ),
                    Container(
                      width: 80.0,
                      child: IconButton(
                          icon: Icon(Icons.add_reaction), onPressed: () {}),
                    ),
                    Container(
                      width: 80.0,
                      child: IconButton(
                          icon: Icon(Icons.boy_sharp), onPressed: () {}),
                    ),
                    Container(
                      width: 80.0,
                      child: IconButton(
                          icon: Icon(Icons.card_giftcard), onPressed: () {}),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Text(widget.testValue),
              Padding(padding: EdgeInsets.all(8)),
              Text(
                'Top Offers',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              images[index],
                              width: 350,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            bottom: -11,
                            left: -12,
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Reedem()),
                                    (route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide.none,
                                  )),
                              child: const Text(
                                'REDEEM',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              Padding(padding: EdgeInsets.all(10)),
            ],
          ),
        ),
      ],
    );
  }
}
