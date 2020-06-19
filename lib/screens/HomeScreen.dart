import 'package:e_triage/screens/EmployeeScreen.dart';
import 'package:e_triage/screens/TPCScreen.dart';
import 'package:e_triage/screens/VisitorScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color blueColorBackground = Colors.blueAccent;
FaIcon menuIcon = FaIcon(FontAwesomeIcons.hospital);
String titleBar ="Employees";

PageController pageController;

class NavBarFooter extends StatelessWidget {
  const NavBarFooter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _page = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.animateToPage(page, 
      duration: const Duration(milliseconds: 600), 
      curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      
      if(page == 0) {
        blueColorBackground = Colors.blueAccent;
        menuIcon = FaIcon(FontAwesomeIcons.hospital);
        titleBar ="Employees";
      } else if (page == 1) {
        blueColorBackground = Colors.orangeAccent;
        menuIcon = FaIcon(FontAwesomeIcons.user);
        titleBar="Visitors";
      } else if (page == 2) {
        blueColorBackground = Colors.purple;
        menuIcon = FaIcon(FontAwesomeIcons.users);
        titleBar ="Third Party Contractor";
      }

      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColorBackground,
        title:Text(
          titleBar,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.qrcode, 
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/showqr');
            },
          )
        ],
      ),
      body: new PageView(
        children: [
          Text('ddd'),
        ],
        // children: [
        //   EmployeeScreen(),
        //   VisitorScreen(),
        //   TPCScreen(),
        // ],
        onPageChanged: onPageChanged,
        controller: pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: blueColorBackground,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.hospitalUser, 
              color: Colors.white,
            ),
            title: Text(
              "Employees",
              style: TextStyle(
                color: Colors.white
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.users, 
              color: Colors.white,
            ),
            title: Text(
              "Visitors",
              style: TextStyle(
                color: Colors.white
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.userFriends, 
              color: Colors.white,
            ),
            title: Text(
              "TPC",
              style: TextStyle(
                color: Colors.white
              ),
            )
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      )
    );
  }
}