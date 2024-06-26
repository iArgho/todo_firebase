import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/Database%20Service/database_service.dart';
import 'package:todo_firebase/Screens/todo_task_dialog_screen.dart';
import 'package:todo_firebase/Widgets/official_task_widget.dart';
import 'package:todo_firebase/Widgets/personal_task_widget.dart';
import 'package:todo_firebase/Widgets/task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _personal = true;
  Stream<QuerySnapshot>? todoStream;

  loadTask() async {
    todoStream =
        await DatabaseService().getTask(_personal ? "Personal" : "Official");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent.shade400,
        onPressed: () {
          openBox(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Todo',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PersonalTaskWidget(
                      isSelected: _personal,
                      onTap: () async {
                        _personal = true;
                        await loadTask();
                      },
                    ),
                    OfficialTaskWidget(
                      isSelected: !_personal,
                      onTap: () async {
                        _personal = false;
                        await loadTask();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TaskList(
                  todoStream: todoStream,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => TodoTaskDialog(),
    );
  }
}
