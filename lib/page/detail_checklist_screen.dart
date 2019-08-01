import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wedding_planner/component/todo_badge.dart';
import 'package:wedding_planner/model/todo_list_model.dart';

class DetailChecklist extends StatefulWidget {
  final String categoriId;


DetailChecklist({
   @required this.categoriId,

});
  @override
  _DetailChecklistState createState() {
 return _DetailChecklistState();
  }
 
}

class _DetailChecklistState extends State<DetailChecklist> with SingleTickerProviderStateMixin {
    AnimationController _controller;
   Animation<Offset> _animation; 
   

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0.0, 0.0))
        .animate(_controller);
  }
  @override
  Widget build(BuildContext context) {
        _controller.forward();
    return ScopedModelDescendant<TodoListModel>(
      builder: (BuildContext contex, Widget child, TodoListModel model){
        var _categori;

        try {
         _categori = model.categoris.firstWhere((it) => it.id == widget.categoriId);
        } catch (e) {
          return Container(
            color: Colors.blue,
          );
        }
        var _checks = model.checks.where((it) => it.parent == widget.categoriId).toList();
       
      return Container(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
               elevation: 0,
               title: Text("Detail Checklis"),
              iconTheme: IconThemeData(color: Colors.black26),
              brightness: Brightness.light,
              backgroundColor: Colors.black,
              actions: [
                SimpleAlertDialog(
                  color: Colors.black,
                  onActionPressed: () => model.removeCategori(_categori),
                ),
              ],
            ),
          body: Padding(
            padding:EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0), 
            child: Column(
              children: <Widget>[
                Container(
                   margin: EdgeInsets.symmetric(horizontal: 36.0, vertical: 0.0),
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TodoBadge(
                        color: Colors.black,
                        codePoint: _categori.codePoint,
                        id: _categori.id,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 4.0),
                      ),
                  Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        var check = _checks[index];
                        return Container(
                          padding: EdgeInsets.only(left: 22.0, right: 22.0),
                          child: ListTile(
                            onTap: () => model.updateCheck(check.copy(
                                isCompleted: check.isCompleted == 1 ? 0 : 1)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 8.0),
                            leading: Checkbox(
                                onChanged: (value) => model.updateCheck(
                                    check.copy(isCompleted: value ? 1 : 0)),
                                value: check.isCompleted == 1 ? true : false),
                            trailing: IconButton(
                              icon: Icon(Icons.delete_outline),
                              onPressed: () => model.removeCheck(check),
                            ),
                            title: Text(
                              check.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: _checks.length,
                    ),
                  ),
                ),
                    ],
                  ),
                )
              ],
            ),
            ),
           floatingActionButton: FloatingActionButton(
              heroTag: 'fab_new_categori',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         AddTodoScreen(taskId: widget.taskId, heroIds: _hero),
                //   ),
                // );
              },
              tooltip: 'New Checklist',
              foregroundColor: Colors.white,
              child: Icon(Icons.add),
            ), 
          ),
      );
      }
    );
  }
    @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
typedef void Callback();

class SimpleAlertDialog extends StatelessWidget {
  final Color color;
  final Callback onActionPressed;

  SimpleAlertDialog({
    @required this.color,
    @required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: color,
      child: Icon(Icons.delete),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete this card?'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        'This is a one way street! Deleting this will remove all the task assigned in this card.'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Delete'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    onActionPressed();
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  textColor: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
