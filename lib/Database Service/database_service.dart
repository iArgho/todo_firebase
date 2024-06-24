import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future addPersonalTask(
      Map<String, dynamic> userPersonalMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Personal")
        .doc(id)
        .set(userPersonalMap);
  }

  Future addOfficialTask(
      Map<String, dynamic> userOfficialMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Official")
        .doc(id)
        .set(userOfficialMap);
  }

  Future<Stream<QuerySnapshot>> getTask(String task) async {
    return await FirebaseFirestore.instance.collection(task).snapshots();
  }
}
