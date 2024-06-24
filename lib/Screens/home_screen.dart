import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/Database%20Service/database_service.dart';
import 'package:todo_firebase/Screens/todo_task_dialog_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _personal = true, _official = false, _suggest = false;
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

  Widget getTask() {
    return StreamBuilder<QuerySnapshot>(
      stream: todoStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot docSnap = snapshot.data!.docs[index];
                return CheckboxListTile(
                  activeColor: Colors.greenAccent.shade400,
                  title: Text(docSnap["task"]),
                  value: _suggest,
                  onChanged: (newValue) {
                    setState(() {
                      _suggest = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              },
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
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
                    _personal
                        ? Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                'Personal',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              _personal = true;
                              _official = false;
                              await loadTask();
                              setState(() {});
                            },
                            child: const Text(
                              'Personal',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    _official
                        ? Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 57, 254, 169),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                'Official',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              _personal = false;
                              _official = true;
                              await loadTask();
                              setState(() {});
                            },
                            child: const Text(
                              'Official',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                getTask(),
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
