import 'package:flutter/material.dart';
class Aasd extends StatelessWidget {
  const Aasd({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('asd')
      ),
      body: Column(
        children: [
          Container(
            child: Text('1 2 3 4')
          ),
          Expanded(
            child: Container(
              SingleChildScrollView(
                child:Text()
              )
            ),
          ),
        ]
      )
    );
  }
}