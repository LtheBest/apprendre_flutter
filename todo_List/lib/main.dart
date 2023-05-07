import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  // Ajouter une tâche à la liste
  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  // Supprimer une tâche de la liste
  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  // Cocher une tâche pour la marquer comme terminée
  void _toggleTodoItem(int index) {
    setState(() {
      if (_todoItems[index].startsWith("✓ ")) {
        _todoItems[index] = _todoItems[index].substring(2);
      } else {
        _todoItems[index] = "✓ " + _todoItems[index];
      }
    });
  }
  // Modifier une tâche existante
  void _editTodoItem(int index) {
    String currentTask = _todoItems[index];
    TextEditingController controller = TextEditingController(text: currentTask);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Enter new task",
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Save"),
              onPressed: () {
                setState(() {
                  _todoItems[index] = controller.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

  // Afficher toutes les tâches dans une liste
  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return ListTile(
            title: Text(_todoItems[index]),
            onTap: () => _toggleTodoItem(index),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editTodoItem(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeTodoItem(index),
                ),
              ],
            ),
          );
        }
        return null;
      },
    );
  }


    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }

  // Écran pour ajouter une tâche
  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add a new task'),
          ),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              hintText: 'Enter something to do...',
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
        );
      }),
    );
  }
}
