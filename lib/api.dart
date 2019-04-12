import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

const DB = 'moments';
const MOMENTS = 'm';

class Moment {
  String key;
  String note;
  DateTime date;

  static final _Database _database = FirebaseImpl();

  Moment({this.key, this.note, this.date});

  static Future<Moment> get(String key) async {
    final doc = await _database.get('$DB/${await Auth.userId}/$MOMENTS/$key');
    return Moment.fromJson(doc);
  }

  static Future<List<Moment>> getAll() async {
    final doc = await _database.get('$DB/${await Auth.userId}/$MOMENTS');
    return doc.map((d) => Moment.fromJson(d));
  }

  Future<void> delete() async =>
      _database.remove('$DB/${await Auth.userId}/$MOMENTS/$key');

  factory Moment.fromJson(Map doc) => Moment(
        key: doc['k'],
        note: doc['n'],
        date: DateTime.fromMillisecondsSinceEpoch(doc['d']),
      );

  Map toJson() => {
        'k': key,
        'n': note,
        'd': date.millisecondsSinceEpoch,
      };

  Future<void> save() async {
    String uid = await _database.getUID();
    String path = '$DB/$uid/$MOMENTS/';
    return key == null
        ? _database.insert(path, this)
        : _database.save(path + key, this);
  }
}

abstract class _Database {
  Future<void> save(String path, dynamic obj);

  Future<void> insert(String path, obj);

  Future<String> getUID();

  Future get(String path);

  Future<void> remove(String path);
}

class FirebaseImpl extends _Database {
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
  Future<String> getUID() async =>
      (await FirebaseAuth.instance.currentUser()).uid;

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

class Auth {
  static String _userId;

  static Future<String> get userId async {
    if (_userId == null) {
      _userId = (await FirebaseAuth.instance.currentUser()).uid;
    }
    return userId;
  }
}
