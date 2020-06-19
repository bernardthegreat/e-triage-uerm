import 'package:flutter/material.dart';

// import 'package:e_triage/screens/HomeScreen.dart';
// import 'package:e_triage/screens/qr_code/scan.dart';
// import 'package:e_triage/screens/qr_code/show.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  // "/": (BuildContext context) => NavBarFooter(),
  '/':(_)=> Index(),
  // "/scanqr": (BuildContext context) => ScanPage(),
  // "/showqr": (BuildContext context) => ShowQR(),
};

class Index extends StatelessWidget {
  // GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        child: Text('ss'),
        // key: _formKey,
        // child: FormBuilderTextField(
        //   attribute: 'Sample',
        //   keyboardType: TextInputType.text,
        // ),
      ),
    );
  }
}