import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:todo_firebase/Database%20Service/database_service.dart';

class TodoTaskDialog extends StatelessWidget {
  TodoTaskDialog({super.key});
  final TextEditingController _textTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Todo Task',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.cancel_rounded, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _textTEController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your task here',
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                maxLines: 10,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String id = randomAlphaNumeric(10);

                    Map<String, dynamic> userTodo = {
                      "task": _textTEController.text,
                      "Id": id,
                    };

                    DatabaseService().addPersonalTask(userTodo, id);

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
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
                ElevatedButton(
                  onPressed: () {
                    String id = randomAlphaNumeric(10);

                    Map<String, dynamic> userTodo = {
                      "task": _textTEController.text,
                      "Id": id,
                    };

                    DatabaseService().addOfficialTask(userTodo, id);

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 57, 254, 169),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
