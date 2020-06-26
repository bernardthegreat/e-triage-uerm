import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
// import 'package:responsive_builder/responsive_builder.dart';

class PostRegistration extends StatefulWidget {

  @override
  _PostRegistrationState createState() => _PostRegistrationState();
}

class _PostRegistrationState extends State<PostRegistration> {
  
  Widget build(BuildContext context) {
    final Map code = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your QR Code'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Center(
              //   child: Text(
              //     'Congrats!',
              //     style: TextStyle(
              //       fontSize: 28
              //     ),
              //   ),
              // ),
              // SizedBox(height: 20,),
              // CircleAvatar(
              //   radius: 50,
              //   backgroundColor: Colors.green,
              //   child: (
              //     IconButton(
              //       iconSize: 30,
              //       icon: FaIcon(
              //         FontAwesomeIcons.check,
              //         color: Colors.white,
              //       ),
              //       onPressed: () {
              //         Navigator.of(context).popUntil(ModalRoute.withName('/health_declaration'));
              //       },
              //     )
              //   ),
              // ),
              Center(
                child: Text(
                  'Please click the CHECK to proceed',
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
              ),
              
              InkWell(
                child: Container(
                  margin: EdgeInsets.all(300),
                  child:  QrImage(
                    //plce where the QR Image will be shown
                    data: code['code'],
                    size: 20
                  ),

                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/health_declaration', arguments: {'code':code['code'],});
                },
              ),
              Center(
                child: Text(
                  'Please remember your code: ${code['code']}',
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}