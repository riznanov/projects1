import 'package:flutter/material.dart';
import 'package:wedding_planner/db/db_provider.dart';
import 'package:wedding_planner/model/categori_model.dart';
import 'package:wedding_planner/model/check_model.dart';
import 'package:wedding_planner/page/detail_checklist_screen.dart';

class Budget extends StatefulWidget {
  Budget ({Key key, Title title}) : super(key:key);
  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> with SingleTickerProviderStateMixin{
  Future<List<Check>> future;
 @override
  void initState() {
    super.initState();
    future = DBProvider.db.getAllCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    
    appBar: AppBar(
      elevation: 0.1,
       backgroundColor: Colors.pink,
       title: Text("Budget Plan"), 
    ),
  body: FutureBuilder<List<Check>>(
    future:  DBProvider.db.getAllCheck(),
      builder: (BuildContext context, AsyncSnapshot<List<Check>> snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              Check check = snapshot.data[index];
              return ListTile(
                onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailChecklist(categoriId: check.id),
              ),
            );
          },
                title: Text(check.name),
                leading: Text(check.id),
                trailing: Icon(Icons.arrow_right),
                
              );
            }
          );
        }
      }
    )
    );
  }
}