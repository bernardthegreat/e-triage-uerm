import 'package:flutter/material.dart';

class UserSearch extends StatefulWidget {
  UserSearch({Key key}) : super(key: key);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('Search User here'),
    );
  }
}