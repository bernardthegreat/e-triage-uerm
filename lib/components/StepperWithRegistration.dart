import 'package:e_triage/models/EmployeesProvider.dart';
import 'package:e_triage/models/SymptomsProvider.dart';
import 'package:e_triage/models/UserHistoriesProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'HealthDeclaration.dart';

class TestHDFForm extends StatefulWidget {
  TestHDFForm({Key key}) : super(key: key);

  @override
  _MainHealthDeclarationState createState() => _MainHealthDeclarationState();
}

class _MainHealthDeclarationState extends State<TestHDFForm> {
  int _currentStep = 0;
  Future _symptoms;
  Future _userHistories;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  _submitTemp() async {
    setState(() {});
    if (_formKey.currentState.saveAndValidate()) {
      var formVals = _formKey.currentState.value;
      print(formVals);
    }
  }

  @override
  void initState() {
    super.initState();
    _symptoms = _geSymptoms();
    _userHistories = _getUserHistories();
  }

  Future<void> _geSymptoms() async {
    await Future.delayed(Duration.zero);
    final symptoms = await Provider.of<SymptomsProvider>(context, listen: false)
        .getSymptoms();
    return symptoms;
  }

  Future<void> _getUserHistories() async {
    await Future.delayed(Duration.zero);
    final symptoms =
        await Provider.of<UserHistoriesProvider>(context, listen: false)
            .getUserHistories();
    return symptoms;
  }

  @override
  Widget build(BuildContext context) {
    final symptoms = Provider.of<SymptomsProvider>(context).symptoms;
    final userHistories = Provider.of<UserHistoriesProvider>(context).userHistories;
    return Scaffold(
        appBar: AppBar(
          title: Text('Health Declaration Form'),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: FormBuilder(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: [
            Expanded(
              child: Stepper(
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      _currentStep == 4
                          ? CircleAvatar(
                              radius: 85,
                              backgroundColor: Colors.green,
                              child: IconButton(
                                iconSize: 80,
                                icon: FaIcon(
                                  FontAwesomeIcons.check,
                                  color: Colors.white,
                                  size: 80,
                                ),
                                onPressed: () {
                                  Provider.of<EmployeesProvider>(context,
                                          listen: false)
                                      .clearEmployee();
                                  Navigator.of(context)
                                      .popUntil(ModalRoute.withName('/'));
                                },
                              ),
                            )
                          : _currentStep == 3
                              ? Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: RaisedButton(
                                    child: Text(
                                      'SUBMIT',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      onStepContinue();
                                      _submitTemp();
                                    },
                                    color: Colors.blue,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(15),
                                  child: FlatButton(
                                    onPressed: () {
                                      onStepContinue();
                                      _submitTemp();
                                    },
                                    color: Colors.blueAccent,
                                    child: const Text('CONTINUE'),
                                  ),
                                ),
                      _currentStep != 4
                          ? FlatButton(
                              onPressed: onStepCancel,
                              color: Colors.redAccent,
                              child: const Text('GO BACK'),
                            )
                          : Text('')
                    ],
                  );
                },
                type: StepperType.horizontal,
                currentStep: _currentStep,
                onStepTapped: (int step) => setState(() => _currentStep = step),
                onStepContinue: _currentStep < 4
                    ? () => setState(() => _currentStep += 1)
                    : null,
                onStepCancel: _currentStep > 0
                    ? () => setState(() => _currentStep -= 1)
                    : null,
                steps: <Step>[
                  Step(
                    title: Text(''),
                    content: TermsAggreeement(),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: Text(''),
                    content: Column(
                      children: [
                        ...symptoms.map((e) => Container(
                          child: FormBuilderSwitch(
                            label: Wrap(
                              children:[
                                Text(e['Name'], 
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18
                                  ),
                                ),
                                Text(" ("+e['OtherName']+")", 
                                  style: TextStyle(
                                    fontSize: 18
                                  )
                                ),
                              ]
                            ),
                            attribute: e['Code'],
                            initialValue: false,
                          )
                        )).toList(),
                      ]
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: Text(''),
                    content: Column(
                      children: [
                        ...userHistories.map((e) => Container(
                          child: FormBuilderSwitch(
                            label: Wrap(
                              children:[
                                Text(e['Name'], 
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18
                                  ),
                                ),
                                Text(" ("+e['OtherName']+")", 
                                  style: TextStyle(
                                    fontSize: 18
                                  )
                                ),
                              ]
                            ),
                            attribute: e['Code'],
                            initialValue: false,
                          )
                        )).toList(),
                      ]
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: Text(''),
                    content: Column(
                      children: [
                        FormBuilderTextField(
                          attribute: 'temp',
                          decoration: InputDecoration(labelText: 'Temperature'),
                          validators: [FormBuilderValidators.required()],
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 3
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: Text(''),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        Center(
                          child: Text(
                            'Congrats you finished the screening!',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // SizedBox(
                        //   height: 50
                        // ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 4
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ]
              )
            ),

            
          ]
      ),
        )  
    );
  }
}
