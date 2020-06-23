import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'Terms.dart';

class TermsAggreeement extends StatelessWidget {
  const TermsAggreeement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Terms(),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}

class Symptoms extends StatelessWidget {
  const Symptoms({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final Map emp = ModalRoute.of(context).settings.arguments;
    return Container(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(
      //     color: Colors.white, //change your color here
      //   ),
      //   title: Text('${emp['name']}'),
      // ),
      child: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(20),
        child: FormBuilder(
          child: Column(
            children: [
              Text('Do you have ANY of the following?'),
              FormBuilderSwitch(
                label: Text('FEVER (LAGNAT)'),
                attribute: "fever",
                initialValue: false,
              ),
              FormBuilderSwitch(
                label: Text('COUGH OR COLDS (UBO O SIPON)'),
                attribute: "cough_colds",
                initialValue: false,
              ),
              FormBuilderSwitch(
                label: Text('DIFFICULTY OF BREATHING  (KINAKAPOS NA HININGA)'),
                attribute: "breathing",
                initialValue: false,
              ),
              FormBuilderSwitch(
                label: Text('HEADACHE (SAKIT NG ULO)'),
                attribute: "headache",
                initialValue: false,
              ),
              FormBuilderSwitch(
                label: Text('SORE THROAT (NAMAMAGANG LALAMUNAN)'),
                attribute: "sore_throat",
                initialValue: false,
              ),
              FormBuilderSwitch(
                label: Text('JOINT PAINS (SAKIT SA KASU-KASUAN)'),
                attribute: "joint_pains",
                initialValue: false,
              ),
              FormBuilderSwitch(
                label: Text('MUSCLE PAINS (SAKIT SA KALAMNAN)'),
                attribute: "muscle_pains",
                initialValue: false,
              ),
              FormBuilderSwitch(
                label: Text(
                    'STOMACH ACHE / DIARRHEA (SAKIT SA TYAN / PAGTATAE)'),
                attribute: "stomach_ache",
                initialValue: false,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class TravelHistory extends StatelessWidget {
  const TravelHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final Map emp = ModalRoute.of(context).settings.arguments;
    return Container(
      child: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(20),
        child: FormBuilder(
          child: Column(
            children: [
              Text('Do you have ANY HISTORY of thhe  following:'),
              FormBuilderSwitch(
                label: Text(
                    'Travel in the past 14 days with local transmission of COVID-19'),
                attribute: "travel_14_days",
                initialValue: false,
              ),
              FormBuilderSwitch(
                label: Text(
                    'Exposure to person with history of travel with local transmission of COVID-19'),
                attribute: "person_with_travel_history",
                initialValue: false,
              ),
              FormBuilderSwitch(
                label: Text(
                    'Exposure to cluster of Individuals with flu-like illness inn household or workplace'),
                attribute: "exposure_to_individuals",
                initialValue: false,
              ),
              FormBuilderSwitch(
                label: Text('Exposure to a confirmed case of COVID-19'),
                attribute: "exposed_to_confirmed_case",
                initialValue: false,
              ),
              FormBuilderSwitch(
                label: Text(
                    'Exposure to a Patient Under Investigation (PUI) for COVID-19'),
                attribute: "sore_throat",
                initialValue: false,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final Map emp = ModalRoute.of(context).settings.arguments;
    return Container(
      child: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(20),
        child: FormBuilder(
          child: Column(
            children: [
              Text('User Information'),
              FormBuilderTextField(
                textAlign: TextAlign.center,
                // style: TextStyle(
                //   fontSize: 30.0
                // ),
                attribute: 'temperature',
                decoration: InputDecoration(
                  labelText: 'Temperature',
                ),
                maxLines: 1,
                validators: [FormBuilderValidators.required()],
              ),
            ],
          ),
        ),
      )),
    );
  }
}



class Registration extends StatelessWidget {
  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();
  
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _key,

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 50,
                  child: Text(
                    'UERM',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                    ),
                  ),
                ),
                FormBuilderTextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                  attribute: 'first_name',
                  decoration: InputDecoration(
                    labelText: 'Firstname',
                  ),
                  maxLines: 1,
                  validators: [FormBuilderValidators.required()],
                ),

                FormBuilderTextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                  attribute: 'last_name',
                  decoration: InputDecoration(
                    labelText: 'Lastname',
                  ),
                  maxLines: 1,
                  validators: [FormBuilderValidators.required()],
                ),

                FormBuilderTextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                  attribute: 'middle_initial',
                  decoration: InputDecoration(
                    labelText: 'Middle Initial',
                  ),
                  maxLines: 1,
                  validators: [FormBuilderValidators.required()],
                ),

                FormBuilderTextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                  attribute: 'contact_no',
                  decoration: InputDecoration(
                    labelText: 'Contact #',
                  ),
                  maxLines: 1,
                  validators: [FormBuilderValidators.required()],
                ),
                FormBuilderTextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontSize: 18),
                  attribute: 'remarks',
                  decoration: InputDecoration(
                    labelText: 'Remarks',
                  ),
                  maxLines: 1,
                  //validators: [FormBuilderValidators.required()],
                ),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   margin: EdgeInsets.all(10),
                //   child: Column(
                //     children: [
                //       RaisedButton.icon(
                //           onPressed: () {
                //             //_search();
                //           },
                //           icon: Icon(FontAwesomeIcons.save),
                //           label: Text('Register'))
                //     ],
                //   ),
                // ),
              ]
            ),
          ),
        ),
        
    );
  }
}
