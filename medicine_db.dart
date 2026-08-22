import 'package:hive_flutter/hive_flutter.dart';

import '../models/medicine_record.dart';

class MedicineDB {
  static const String boxName = 'medicinesBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Box get _box => Hive.box(boxName);

  static Future<void> insertRecord(MedicineRecord record) async {
    await _box.add(record.toMap());
  }

  static List<MedicineRecord> getAllRecords() {
    final List<MedicineRecord> records = [];

    for (final key in _box.keys) {
      final value = _box.get(key);

      if (value is Map) {
        final Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(value);

        records.add(
          MedicineRecord.fromMap(
            key.toString(),
            map,
          ),
        );
      }
    }

    // ترتيب الأحدث أولاً (Hive بيولّد مفاتيح int متسلسلة مع add)
    records.sort((a, b) {
      final int keyA = int.tryParse(a.id ?? '') ?? 0;
      final int keyB = int.tryParse(b.id ?? '') ?? 0;
      return keyB.compareTo(keyA);
    });

    return records;
  }

  static Future<void> deleteRecord(dynamic key) async {
    await _box.delete(key);
  }
}