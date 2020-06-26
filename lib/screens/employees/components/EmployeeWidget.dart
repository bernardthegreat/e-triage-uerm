import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/EmployeesProvider.dart';

class Employees extends StatelessWidget {
  const Employees({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final employees = Provider.of<EmployeesProvider>(context).employee;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (employees.length == 0) {
          return Container(
            color: Colors.red[100],
            padding: EdgeInsets.all(20),
            child: Text(
              'No employee found or employee is inactive',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5.copyWith(
                color: Colors.red[900]
              ),
            ),
          );
        }
        return Column(
          children: [
            ...employees
                .map((e) => ListTile(
                      title: Text(e['NAME']),
                      subtitle: Text(e['DEPT_DESC']),
                      leading: CircleAvatar(
                        child: Text(e['CODE']),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(
                            '/health_declaration_form',
                            arguments: {
                              'code': e['CODE'],
                              'name': e['NAME'],
                            });
                      },
                    ))
                .toList(),
          ],
        );
      },
    );
  }
}
