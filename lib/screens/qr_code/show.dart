import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';

String qrData = "1212321";

class ShowQR extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
                      data: qrData,
                    ),
                  );
                }

                if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
                  return Container(
                    child:  QrImage(
                      //plce where the QR Image will be shown
                      data: qrData,
                    ),
                  );
                }

                if (sizingInformation.deviceScreenType == DeviceScreenType.watch) {
                  return Container(
                    child:  QrImage(
                      //plce where the QR Image will be shown
                      data: qrData,
                    ),
                  );
                }

                return Container(
                  child:  QrImage(
                    //plce where the QR Image will be shown
                    data: qrData,
                  ),
                );
              }
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                'Your QR Code'
              ),
            ),
          ],
        ),
      ),
    );
  }
}