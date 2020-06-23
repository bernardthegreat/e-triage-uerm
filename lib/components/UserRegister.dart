import 'package:e_triage/models/VisitorsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyData {
  String temperature = '';
}

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  String _errorMessage = '';
  bool _isLoading = false;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  _saveVisitor() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    if (_formKey.currentState.saveAndValidate()) {
      var formVals = _formKey.currentState.value;
      final response =
          await Provider.of<VisitorsProvider>(context, listen: false)
              .saveVisitor(formVals);

      if (response['error'] != null) {
        setState(() {
          _errorMessage = response['error'];
          _isLoading = false;
        });
        return;
      }

      Navigator.of(context).pushNamed('/health_declaration_form', arguments: {'code':response['code'],});
      //Navigator.of(context).pushNamed('/post_registration', arguments: {'code':response['code'],});
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FormBuilder(
            key: _formKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  child: Text('UERM'),
                ),
                FormBuilderTextField(
                  attribute: 'firstName',
                  decoration: InputDecoration(labelText: 'First Name'),
                  validators: [FormBuilderValidators.required()],
                ),
                FormBuilderTextField(
                  attribute: 'middleInitial',
                  decoration: InputDecoration(labelText: 'Middle Initial'),
                  validators: [FormBuilderValidators.required()],
                ),
                FormBuilderTextField(
                  attribute: 'lastName',
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validators: [FormBuilderValidators.required()],
                ),
                FormBuilderTextField(
                  attribute: 'contactNo',
                  decoration: InputDecoration(labelText: 'Contact #'),
                  validators: [FormBuilderValidators.required()],
                ),
                FormBuilderTextField(
                  attribute: 'remarks',
                  decoration: InputDecoration(labelText: 'Remarks'),
                  // validators: [FormBuilderValidators.required()],
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : Column(
                        children: <Widget>[
                          SizedBox(
                            height:20
                          ),
                          RaisedButton.icon(
                            onPressed: () {
                              _saveVisitor();
                            },
                            icon: Icon(FontAwesomeIcons.save),
                            label: Text('Save'),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: FlatButton(
                          //     child: Text('Cancel'),
                          //     onPressed: () {
                          //       Navigator.of(context).pop();
                          //       // Navigator.of(context)
                          //       //     .popUntil(ModalRoute.withName('/'));
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
