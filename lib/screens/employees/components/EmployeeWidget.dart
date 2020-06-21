import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';


class Employees extends StatelessWidget {
  const Employees({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final employees = Provider.of<EmployeeProvider>(context).employee;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // if(employees.length == 0) 
        // {
        //   return Text('No employee found');
        // }
          return Column(
            children: [
              ListTile(
                title: Text('result'),
                subtitle: Text('result'),
                leading: CircleAvatar(
                  child: Text('result'),
                ),
                onTap: (){
                  Navigator.of(context).pushNamed('/health_declaration_form', arguments: {'name':'Employee Data',});
                },
              )
            ],
          );
        
      },
    );
  }
}