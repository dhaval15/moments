import 'package:date_format/date_format.dart';
import 'package:moments/api/api.dart';

const DB = 'moments';
const MOMENTS = 'm';

class Moment {
  String key;
  String note;
  DateTime date;
  
  String get formattedDate => formatDate(date, [dd, ' ', M, ' ', yy]);
  
  static final Database _database = Database();
  
  Moment({this.key, this.note, this.date});
  
  static Future<Moment> get(String key) async {
    final doc = await _database.get('$DB/${await PhoneAuthAPI.currentUID}/$MOMENTS/$key');
    return Moment.fromJson(doc);
  }
  
  static Future<List<Moment>> getAll() async {
    final path = '$DB/${await PhoneAuthAPI.currentUID}/$MOMENTS';
    final doc = Map.from(await _database.get(path));
    return doc.values.map((v) => Moment.fromJson(v)).toList();
  }
  
  Future<void> delete() async =>
      _database.remove('$DB/${await PhoneAuthAPI.currentUID}/$MOMENTS/$key');
  
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
    String uid = await PhoneAuthAPI.currentUID;
    String path = '$DB/$uid/$MOMENTS/';
    return key == null
        ? _database.insert(path, this)
        : _database.save(path + key, this);
  }
}