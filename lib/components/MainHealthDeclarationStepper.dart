import 'package:e_triage/models/EmployeesProvider.dart';
import 'package:e_triage/models/HealthDeclarationsProvider.dart';
import 'package:e_triage/models/SwitchProvider.dart';
import 'package:e_triage/models/SymptomsProvider.dart';
import 'package:e_triage/models/UserHistoriesProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'HealthDeclaration.dart';
import 'Terms.dart';

class MainHealthDeclarationStepper extends StatefulWidget {
  MainHealthDeclarationStepper({Key key}) : super(key: key);

  @override
  _MainHealthDeclarationState createState() => _MainHealthDeclarationState();
}

class _MainHealthDeclarationState extends State<MainHealthDeclarationStepper> {
  Color background = Colors.white;
  Color textColor = Colors.black;
  FaIcon stepperIcon = FaIcon(FontAwesomeIcons.check);
  Color buttonColor = Colors.green;
  String lastStepTextText =
      'You have completed the E-Triage, you may now proceed to entering UERM premises!';
  int _currentStep = 0;
  Future _symptoms;
  Future _userHistories;

  static final DateTime now = new DateTime.now();
  static final DateTime date = new DateTime(now.year, now.month, now.day, now.hour, now.minute);
  

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  _saveHealthDeclarations() async {
    if (_formKey.currentState.saveAndValidate()) {
      var formVals = _formKey.currentState.value;
      final response =
          await Provider.of<HealthDeclarationsProvider>(context, listen: false)
              .saveHealthDeclaration(formVals);
    }
  }


  _submitDetails() async {
    setState(() {});

    if (_formKey.currentState.saveAndValidate()) {
      var formVals = _formKey.currentState.value;

      formVals.forEach((key, val) {
        if (key != 'accept_terms') {
          if (val == true) {
            setState(() {
              background = Colors.redAccent;
              stepperIcon = FaIcon(
                FontAwesomeIcons.times,
                color: Colors.white,
                size: 80,
              );
              buttonColor = Colors.red[900];
              lastStepTextText =
                  'Please proceed to COVID ER for proper management and evaluation.';
            });
          }
        }
      });
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
    final Map user = ModalRoute.of(context).settings.arguments;
    final symptoms = Provider.of<SymptomsProvider>(context).symptoms;
    final userHistories =
        Provider.of<UserHistoriesProvider>(context).userHistories;

    if (user['code'] == null) {
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
      return Container();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Health Declaration Form - ${user['code']}'),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: FormBuilder(
          key: _formKey,
          autovalidate: true,
          child: Column(children: [
            Expanded(
                child: Stepper(
                    controlsBuilder: (BuildContext context,
                        {VoidCallback onStepContinue,
                        VoidCallback onStepCancel}) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          _currentStep == 4
                              ? Column(
                                  children: [
                                    SizedBox(height: 15),
                                    CircleAvatar(
                                      radius: 85,
                                      backgroundColor: buttonColor,
                                      child: IconButton(
                                        iconSize: 80,
                                        icon: stepperIcon,
                                        onPressed: () {
                                          Provider.of<EmployeesProvider>(
                                                  context,
                                                  listen: false)
                                              .clearEmployee();
                                          Navigator.of(context).popUntil(
                                              ModalRoute.withName('/'));
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Column(
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          '- Wear mask at all times',
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '- Observe physical distancing',
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '- Wash or sanitize your hands regularly',
                                        ),
                                        SizedBox(height: 20),
                                        Center(
                                          child: Text(
                                            date.toString(),
                                            style: TextStyle(fontSize: 28),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                                          _saveHealthDeclarations();
                                        },
                                        color: Colors.blue,
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.all(15),
                                      child: FlatButton(
                                        onPressed: () {
                                          onStepContinue();
                                          _submitDetails();
                                        },
                                        color: Colors.blueAccent,
                                        child: const Text('CONTINUE'),
                                      ),
                                    ),
                          _currentStep != 4
                              ? FlatButton(
                                  onPressed: onStepCancel,
                                  color: Colors.black,
                                  child: const Text('GO BACK'),
                                )
                              : Text('')
                        ],
                      );
                    },
                    type: StepperType.horizontal,
                    currentStep: _currentStep,
                    onStepTapped: (int step) =>
                        setState(() => _currentStep = step),
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
                    content: Column(children: [
                      ...symptoms
                          .map((symp) => OptionItem(
                                attribute: symp['Code'],
                                label: symp['Name'],
                                otherName: symp['OtherName'],
                              ))
                          .toList(),
                    ]),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: Text(''),
                    content: Column(children: [
                      ...userHistories
                          .map((hist) => OptionItem(
                                attribute: hist['Code'],
                                label: hist['Name'],
                                otherName: hist['OtherName'],
                              ))
                          .toList(),
                    ]),
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
                          key: Key('temp'),
                          decoration: InputDecoration(labelText: 'Temperature'),
                          validators: [FormBuilderValidators.required()],
                        ),
                        // FormBuilderTextField(
                        //   attribute: 'code',
                        //   key: Key('code'),
                        //   decoration: InputDecoration(labelText: 'Fullname'),
                        //   initialValue: user['name'],
                        //   readOnly: true,
                        // ),
                        FormBuilderDropdown(
                          initialValue: user['code'],
                          attribute: 'code',
                          decoration: InputDecoration(labelText: 'Fullname'),
                          validators: [FormBuilderValidators.required()],
                          items: [
                            DropdownMenuItem(
                              value: user['code'],
                              key: Key('code'),
                              child: Text(user['name']),
                            ),
                          ],
                        ),
                        FormBuilderCheckbox(
                          attribute: 'accept_terms',
                          label: Flexible(
                              child: Text(
                                  'I certify that the information I have given is true, correct, and complete. I understand that failure to answer any question or giving false answer can be penalized in accordance with law. I voluntarily and freely consent to the collection, processing, sharing and storage of the above personal information in accordance with the Data Privacy Act of 2012 and its Implementing Rules and Regulations.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ))),
                          validators: [
                            FormBuilderValidators.requiredTrue(
                              errorText:
                                  "You must accept terms and conditions to continue",
                            ),
                          ],
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
                        Flexible(
                          child: Text(
                            lastStepTextText,
                            style: Theme.of(context).textTheme.headline6,
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
                ])),
          ]),
        ));
  }
}

class OptionItem extends StatefulWidget {
  final label;
  final attribute;
  final otherName;
  final asd;

  OptionItem({
    this.label,
    this.attribute,
    this.otherName,
    this.asd,
  });

  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FormBuilderSwitch(
      label: Wrap(children: [
        Text(
          widget.label,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18),
        ),
        Text(
          '(${widget.otherName})',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ]),
      attribute: widget.attribute,
      key: Key(widget.attribute),
      initialValue: false,
    ));
  }
}
