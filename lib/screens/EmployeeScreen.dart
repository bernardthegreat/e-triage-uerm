import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:e_triage/components/UermWidgets.dart';
class EmployeeScreen extends StatefulWidget {
  EmployeeScreen({Key key}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {

  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: FormBuilder(
                    key: _key,
                    child: Text('sads'),
                    // child: FormBuilderTextField(
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontSize: 30.0
                    //   ),
                    //   attribute: 'code',
                    //   decoration: InputDecoration(
                    //     labelText: 'Employee Number / Name',
                    //   ),
                    //   maxLines: 1,
                    //   validators: [FormBuilderValidators.required()],
                    // ),
                  )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}