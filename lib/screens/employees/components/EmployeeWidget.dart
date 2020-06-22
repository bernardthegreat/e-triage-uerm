import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/EmployeesProvider.dart';

class Employees extends StatelessWidget {
  const Employees({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final employees = Provider.of<EmployeesProvider>(context).employee;
    print(employees);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (employees.length == 0) {
          return Text('No employee found');
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
                      onTap: (){
                        Navigator.of(context).pushNamed('/health_declaration_form', arguments: {'name':e['NAME'],});
                      },
                    ))
                .toList(),
          ],
        );
      },
    );
  }
}
