import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'HealthDeclaration.dart';
import 'package:e_triage/models/EmployeesProvider.dart';

class MyData {
  String temperature = '';
}

class StepperWithRegistration extends StatefulWidget {
  StepperWithRegistration({Key key}) : super(key: key);

  @override
  _StepperWithRegistrationState createState() =>
      _StepperWithRegistrationState();
}

class _StepperWithRegistrationState extends State<StepperWithRegistration> {
  static int _currentStep = 0;
  static var _focusNode = FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  static MyData data = MyData();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Declaration Form'),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Stepper(
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
                state:
                    _currentStep >= 0 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: Text(''),
                content: Symptoms(),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 1 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: Text(''),
                content: TravelHistory(),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 2 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: Text(''),
                content: Column(
                  children: [
                    TextFormField(
                      focusNode: _focusNode,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Temperature',
                      ),
                      onSaved: (String value) {
                        //print(value);
                        data.temperature = value;
                      },
                    ),
                  ],
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 3 ? StepState.complete : StepState.disabled,
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
                state:
                    _currentStep >= 4 ? StepState.complete : StepState.disabled,
              ),
            ],
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
                              Navigator.of(context).pushNamed('/');
                              //Navigator.of(context).popUntil(ModalRoute.withName('/'));
                            },
                          ),
                        )
                      : _currentStep == 3
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  onStepContinue();
                                  _submitDetails();
                                },
                                color: Colors.blue,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(10),
                              child: FlatButton(
                                onPressed: onStepContinue,
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
          ),
        ),
      ),
    );
  }

  void _submitDetails() {
    final FormState formState = _formKey.currentState;
    print(formState);
    formState.save();
    print("temperature: ${data.temperature}");
  }
}

