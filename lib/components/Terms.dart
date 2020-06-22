import 'package:e_triage/components/UermWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_triage/models/TermsProvider.dart';

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
    print(terms);
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: 
                    Text(
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
                    Text(
                      snapshot.data['body'][0].toString(), 
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15
                      ),
                    ),
                  ],
                ),
                
              ],
            );
        }
      }
    );
  }
}
