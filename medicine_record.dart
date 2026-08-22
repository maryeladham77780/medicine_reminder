class MedicineRecord {
  final String? id;
  final String name;
  final String dose;
  final String dateTime;

  MedicineRecord({
    this.id,
    required this.name,
    required this.dose,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dose': dose,
      'dateTime': dateTime,
    };
  }

  factory MedicineRecord.fromMap(String key, Map<dynamic, dynamic> map) {
    return MedicineRecord(
      id: key,
      name: map['name'],
      dose: map['dose'],
      dateTime: map['dateTime'],
    );
  }
}