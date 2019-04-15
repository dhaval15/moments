import 'package:firebase_database/firebase_database.dart';

abstract class _Database {
  Future<void> save(String path, dynamic obj);
  
  Future<void> insert(String path, obj);
  
  Future get(String path);
  
  Future<void> remove(String path);
}

class Database extends _Database {
  @override
  Future<void> save(String path, obj) =>
      FirebaseDatabase.instance.reference().child(path).set(obj.toJson());
  
  @override
  Future<void> insert(String path, obj) {
    var ref = FirebaseDatabase.instance.reference().child(path).push();
    obj.key = ref.key;
    return ref.set(obj.toJson());
  }
  
  @override
  Future get(String path) async {
    final snapshot =
    await FirebaseDatabase.instance.reference().child(path).once();
    return snapshot.value;
  }
  
  @override
  Future<void> remove(String path) {
    return FirebaseDatabase.instance.reference().child(path).set(null);
  }
}