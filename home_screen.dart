import 'package:flutter/material.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoProvider _todoProvider = TodoProvider();
  final TextEditingController _controller = TextEditingController();

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Task'),
        content: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'What needs to be done?'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _todoProvider.addTask(_controller.text));
              _controller.clear();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks'), centerTitle: true),
      body: _todoProvider.tasks.isEmpty
          ? const Center(child: Text('No tasks yet. Add some!'))
          : ListView.builder(
              itemCount: _todoProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = _todoProvider.tasks[index];
                return TodoTile(
                  task: task,
                  onToggle: () => setState(() => _todoProvider.toggleTask(task.id)),
                  onDelete: () => setState(() => _todoProvider.deleteTask(task.id)),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
