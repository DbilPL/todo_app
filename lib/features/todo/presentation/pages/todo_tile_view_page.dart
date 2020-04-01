import 'package:flutter/material.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';

class TodoTileViewPage extends StatefulWidget {
  final TODOModel todo;

  TodoTileViewPage({Key key, this.todo}) : super(key: key);

  @override
  _TodoTileViewPageState createState() => _TodoTileViewPageState();
}

class _TodoTileViewPageState extends State<TodoTileViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your todo'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
            ),
            Text(
              'Title: ',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              widget.todo.title,
              style: TextStyle(
                fontSize: 23,
                color: Theme.of(context).textTheme.caption.color,
              ),
            ),
            Text(
              'Body: ',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              widget.todo.body,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).textTheme.caption.color,
              ),
            ),
            Text(
              'Date: ',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              widget.todo.date != null
                  ? '${widget.todo.date.year}/${widget.todo.date.month}/${widget.todo.date.day} ${widget.todo.date.hour}:${widget.todo.date.minute < 10 ? '0' + widget.todo.date.minute.toString() : widget.todo.date.minute}'
                  : 'No date',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.caption.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
