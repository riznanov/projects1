import 'package:flutter/material.dart';
import 'package:wedding_planner/db/db_provider.dart';
import 'package:wedding_planner/model/categori_model.dart';
import 'package:wedding_planner/page/detail_checklist_screen.dart';


class Checklist extends StatefulWidget {
  Checklist({Key key, Title title}) : super(key:key);
 
  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist>  with SingleTickerProviderStateMixin {
  
@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      
     appBar: AppBar(
       elevation: 0.1,
       backgroundColor: Colors.pink,
       title: Text("Wedding Cheklist"),
     ), 
     
    body: FutureBuilder<List<Categori>>(
      future: DBProvider.db.getAllCategori(),
      builder: (BuildContext context, AsyncSnapshot<List<Categori>> snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              Categori categori = snapshot.data[index];
              return ListTile(
                onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailChecklist(categoriId: categori.id),
              ),
            );
          },
                title: Text(categori.name),
                leading: Text(categori.id),
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