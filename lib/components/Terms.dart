import 'package:e_triage/components/UermWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_triage/models/TermsProvider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Terms extends StatefulWidget {
  Terms({Key key}) : super(key: key);

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Future _terms;

  @override
  void initState() {
    super.initState();
    _terms = _getTerms();
  }

  Future _getTerms() async {
    await Future.delayed(Duration.zero);
    final terms =
        await Provider.of<TermsProvider>(context, listen: false).getTerms();
    return terms;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _terms,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              return Wrap(
                children: [
                  ResponsiveBuilder(builder: (context, sizingInformation) {
                    if (sizingInformation.deviceScreenType ==
                        DeviceScreenType.mobile) {
                      return Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              snapshot.data['heading'].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data['body'][0].toString(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ]);
                    }

                    return Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            snapshot.data['heading'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data['body'][0].toString(),
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ]);
                  }),
                ],
              );
          }
        });
  }
}

class UserTerms extends StatefulWidget {
  UserTerms({Key key}) : super(key: key);

  @override
  _UserTermsState createState() => _UserTermsState();
}

class _UserTermsState extends State<UserTerms> {
  @override
  Future _terms;

  @override
  void initState() {
    super.initState();
    _terms = getUserTerms();
  }

  Future getUserTerms() async {
    await Future.delayed(Duration.zero);
    final terms =
        await Provider.of<TermsProvider>(context, listen: false).getUserTerms();
    return terms;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _terms,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              print(snapshot);
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'I certify that the information I have given is true, correct, and complete. I understand that failure to answer any question or giving false answer can be penalized in accordance with law. I voluntarily and freely consent to the collection, processing, sharing and storage of the above personal information in accordance with the Data Privacy Act of 2012 and its Implementing Rules and Regulations.',
                  ),
                ),
              );
          }
        });
  }
}
