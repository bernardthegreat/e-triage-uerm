import 'package:e_triage/components/DirectionsText.dart';
import 'package:e_triage/components/UermWidgets.dart';
import 'package:e_triage/models/EmployeesProvider.dart';
import 'package:e_triage/models/HealthDeclarationsProvider.dart';
// import 'package:e_triage/models/SwitchProvider.dart';
import 'package:e_triage/models/SymptomsProvider.dart';
import 'package:e_triage/models/UserHistoriesProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:responsive_builder/responsive_builder.dart';

import 'HealthDeclaration.dart';
// import 'Terms.dart';

class MainHealthDeclarationStepper extends StatefulWidget {
  MainHealthDeclarationStepper({Key key}) : super(key: key);

  @override
  _MainHealthDeclarationState createState() => _MainHealthDeclarationState();
}

class _MainHealthDeclarationState extends State<MainHealthDeclarationStepper> {
  Color background = Colors.white;
  Color textColor = Colors.black;
  FaIcon stepperIcon = FaIcon(FontAwesomeIcons.check);
  Color buttonColor = Colors.green[900];
  String lastStepTextText = 'You may now enter the UERM premises.';
  int _currentStep = 0;
  Future _symptoms;
  Future _userHistories;
  Color _backgroundColor = Colors.white;
  Map _formValsConcat;

  static final DateTime now = new DateTime.now();
  static final DateTime date =
      new DateTime(now.year, now.month, now.day, now.hour, now.minute);

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  _saveHealthDeclarations({BuildContext context}) async {
    if (_formKey.currentState.saveAndValidate()) {
      var formVals = {
        ..._formKey.currentState.value,
        ..._formValsConcat,
      };
      final response =
          await Provider.of<HealthDeclarationsProvider>(context, listen: false)
              .saveHealthDeclaration(formVals);
      if (response['isForCovidEr']) {
        setState(() {
          background = Colors.redAccent;
          stepperIcon = FaIcon(
            FontAwesomeIcons.times,
            color: Colors.white,
            size: 80,
          );
          buttonColor = Colors.red[900];
          lastStepTextText =
              Provider.of<HealthDeclarationsProvider>(context, listen: false)
                  .forCovidErMessage;
        });
        _currentStep = 4;
        _backgroundColor = Theme.of(context).errorColor;
        FocusScope.of(context).unfocus();
        return;
      }
      // setState(() {
      //   _forCovidEr = false;
      //   _isAlertShown = true;
      // });
      setState(() {
        _currentStep = 4;
        _backgroundColor = Colors.green;
      });
      FocusScope.of(context).unfocus();
    }
  }

  _submitDetails() async {
    if (_formKey.currentState.saveAndValidate()) {
      final formVal = _formKey.currentState.value;
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
    await Provider.of<SymptomsProvider>(context, listen: false).getSymptoms();
    // return symptoms;
  }

  Future<void> _getUserHistories() async {
    await Future.delayed(Duration.zero);
    await Provider.of<UserHistoriesProvider>(context, listen: false)
        .getUserHistories();
    // return symptoms;
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

    var formBuilder = FormBuilder(
      key: _formKey,
      autovalidate: true,
      child: Column(children: [
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
                          ? SuccessMessage(
                              title: lastStepTextText,
                              buttonColor: buttonColor,
                              date: date,
                              stepperIcon: stepperIcon,
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
                                      // print(_currentStep);
                                      // onStepContinue();
                                      _saveHealthDeclarations(context: context);
                                      // _saveHealthDeclarations();
                                    },
                                    color: Colors.blue,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(15),
                                  child: FlatButton(
                                    onPressed: () {
                                      _formKey.currentState.saveAndValidate();
                                      _formValsConcat =
                                          _formKey.currentState.value;
                                      onStepContinue();
                                      // _submitDetails();
                                    },
                                    color: Colors.blueAccent,
                                    child: Text('Continue'),
                                  ),
                                ),
                      _currentStep != 4
                          ? FlatButton(
                              onPressed: onStepCancel,
                              child: Text('Back'),
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
                state:
                    _currentStep >= 0 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: Text(''),
                content: Column(children: [
                  DirectionsText(
                      title:
                          'Please click on the symptoms that you are currently experiencing. Click Continue to proceed.'),
                  ...symptoms
                      .map((symp) => OptionItem(
                            attribute: symp['Code'],
                            label: symp['Name'],
                            otherName: symp['OtherName'],
                          ))
                      .toList(),
                ]),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 1 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: Text(''),
                content: Column(children: [
                  DirectionsText(
                      title:
                          'Please click on the following items regarding your history of exposure. Click Continue to proceed.'),
                  ...userHistories
                      .map((hist) => OptionItem(
                            attribute: hist['Code'],
                            label: hist['Name'],
                            otherName: hist['OtherName'],
                          ))
                      .toList(),
                ]),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 2 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: Text(''),
                content: Column(
                  children: [
                    FormBuilderTextField(
                      attribute: 'temp',
                      key: Key('temp'),
                      decoration: InputDecoration(labelText: 'Temperature'),
                      keyboardType: TextInputType.number,
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.min(35.0),
                        FormBuilderValidators.max(42.0),
                      ],
                    ),
                    FormBuilderDropdown(
                      initialValue: user['code'],
                      attribute: 'code',
                      decoration: InputDecoration(labelText: 'Fullname'),
                      validators: [
                        FormBuilderValidators.required(),
                      ],
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
                      label: Text(
                          'I certify that the information I have given is true, correct, and complete. I understand that failure to answer any question or giving false answer can be penalized in accordance with law. I voluntarily and freely consent to the collection, processing, sharing and storage of the above personal information in accordance with the Data Privacy Act of 2012 and its Implementing Rules and Regulations.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18,
                          )),
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
                state:
                    _currentStep >= 3 ? StepState.complete : StepState.disabled,
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
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
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
            ])),
      ]),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Declaration Form - ${user['code']}'),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: _backgroundColor,
      body: FutureBuilder(
        // future: Future.wait([
        //   Provider.of<HealthDeclarationsProvider>(context, listen: false)
        //       .isEmployeeDoneToday(userInfo: user),
        //   _symptoms,
        //   _userHistories,
        // ]),
        future: Future.wait([
          Provider.of<HealthDeclarationsProvider>(context, listen: false)
              .isEmployeeDoneToday(userInfo: user),
          _userHistories,
          _symptoms,
        ]),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
            case ConnectionState.none:
              return LoadingWidget();
            default:
              if (!snapshot.hasData) {
                return LoadingWidget();
              }
              // List futures = snapshot.data;
              // print(futures[0]);
              // return Container();
              if (snapshot.data[0]['isDoneToday']) {
                return SuccessMessage(
                    title: snapshot.data[0]['isForCovidEr']
                        ? Provider.of<HealthDeclarationsProvider>(context,
                                listen: false)
                            .forCovidErMessage
                        : Provider.of<HealthDeclarationsProvider>(context,
                                listen: false)
                            .notForCovidErMessage,
                    buttonColor: snapshot.data[0]['isForCovidEr']
                        ? Colors.red[900]
                        : buttonColor,
                    stepperIcon: snapshot.data[0]['isForCovidEr']
                        ? FaIcon(
                            FontAwesomeIcons.times,
                            color: Colors.white,
                            size: 80,
                          )
                        : stepperIcon,
                    date: date);
              }
              return formBuilder;
          }
        },
      ),
    );
  }
}

class SuccessMessage extends StatelessWidget {
  const SuccessMessage({
    Key key,
    @required this.buttonColor,
    @required this.title,
    @required this.stepperIcon,
    @required this.date,
  }) : super(key: key);

  final Color buttonColor;
  final FaIcon stepperIcon;
  final DateTime date;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            // Text('Please proceed to COVID ER for proper evaluation and management.'),
            SizedBox(height: 15),
            CircleAvatar(
              radius: 85,
              backgroundColor: buttonColor,
              child: IconButton(
                iconSize: 80,
                // color: Colors.white,
                icon: stepperIcon,
                onPressed: () {
                  Provider.of<EmployeesProvider>(context, listen: false)
                      .clearEmployee();
                  // Navigator.of(context).popUntil(
                  //     ModalRoute.withName('/'));
                },
              ),
            ),
            SizedBox(height: 15),
            Column(
              children: [
                Text(
                  'KINDLY OBSERVE THE FOLLOWING:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '- Wear mask at all times',
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
                SizedBox(height: 5),
                Text(
                  '- Observe physical distancing',
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
                SizedBox(height: 5),
                Text(
                  '- Wash or sanitize your hands regularly',
                  style: TextStyle(
                      // color: Colors.white,
                      ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    date.toString(),
                    style: TextStyle(
                      fontSize: 28,
                      // color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
