import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/Screens/delete_confirmation_dialog.dart';

class TaskList extends StatelessWidget {
  final Stream<QuerySnapshot>? todoStream;

  const TaskList({
    super.key,
    required this.todoStream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: todoStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot docSnap = snapshot.data!.docs[index];
                return ListTile(
                  tileColor: Colors.greenAccent.shade400,
                  title: Text(
                    "   " + docSnap["task"],
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      print('Document ID to be deleted: ${docSnap.id}');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DeleteConfirmationDialog(docId: docSnap.id);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
