import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String docId;

  const DeleteConfirmationDialog({
    super.key,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Task'),
      content: const Text('Are you sure you want to delete this task?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Delete'),
          onPressed: () async {
            try {
              print('Attempting to delete document with ID: $docId');

              CollectionReference tasks =
                  FirebaseFirestore.instance.collection('tasks');

              await tasks.doc(docId).delete();
              // Log after successful deletion
              print('Document with ID $docId deleted successfully');
              Navigator.of(context).pop();
            } catch (e) {
              print('Error deleting document: $e');
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
