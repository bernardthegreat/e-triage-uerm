import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ResponsiveBuilder(
              builder: (context, sizingInformation) {
                if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
                  return Container(
                    child:  QrImage(
                      //plce where the QR Image will be shown
                      data: code['code'],
                    ),
                  );
                }

                if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
                  return Container(
                    child:  QrImage(
                      //plce where the QR Image will be shown
                      data: code['code'],
                    ),
                  );
                }

                if (sizingInformation.deviceScreenType == DeviceScreenType.watch) {
                  return Container(
                    child:  QrImage(
                      //plce where the QR Image will be shown
                      data: code['code'],
                    ),
                  );
                }

                return Container(
                  child:  QrImage(
                    //plce where the QR Image will be shown
                    data: code['code'],
                  ),
                );
              }
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                code['code']
              ),
            ),
          ],
        ),
      ),
    );
  }
}