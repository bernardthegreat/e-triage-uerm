import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('UERM E-Triage',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.questionCircle, 
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/test_api');
            },
          )
        ],
      ),
      backgroundColor: Colors.grey.shade300,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 100),
            SizedBox(
              height: 300,
              child: PageView(
                controller: controller,
                children: [

                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: new InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/employees');
                      },
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        color: Colors.blueAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.hospitalUser, 
                              size: 50,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text('Employees', 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),   
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  

                  
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: new InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/visitors');
                      },
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.users, 
                              size: 50,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text('Visitors', 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),   
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ),

                  
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: new InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/others');
                      },
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        color: Colors.purple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.users, 
                              size: 50,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text('Others', 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),   
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              //child: Text("Worm"),
            ),
            Center(
              child: Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: WormEffect(),
                ),
              ),
            ),
          ],
        
        ),
      ),
    );
  }
}