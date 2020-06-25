import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:e_triage/components/UermWidgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:e_triage/models/EmployeesProvider.dart';

import 'components/EmployeeWidget.dart';

class EmployeeScreen extends StatefulWidget {
  EmployeeScreen({Key key}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  bool _isLoading = false;
  String _errorMessage = '';

  _search() async {
    setState(() {
      _isLoading = true;
    });

    if (_key.currentState.saveAndValidate()) {

      
      final formVals = _key.currentState.value;

      
      final searchResponse =
          await Provider.of<EmployeesProvider>(context, listen: false)
              .searchEmployee(
        code: formVals['code'],
      );

      if (searchResponse['error'] != null) {
        // print(loginResponse['error']);
        setState(() {
          _errorMessage = searchResponse['error'];
        });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('Employees'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    children: [
                      FormBuilder(
                        key: _key,
                        child: FormBuilderTextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30.0),
                          attribute: 'code',
                          decoration: InputDecoration(
                            labelText: 'Employee Number / Name',
                          ),
                          maxLines: 1,
                          validators: [FormBuilderValidators.required()],
                          initialValue: '7679',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _isLoading
                          ? CircularProgressIndicator()
                          : Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  RaisedButton.icon(
                                      onPressed: () {
                                        _search();
                                      },
                                      icon: Icon(FontAwesomeIcons.search),
                                      label: Text('Search')),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Employees(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
