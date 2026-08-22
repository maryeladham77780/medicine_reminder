import 'package:flutter/foundation.dart';
import '../models/medicine_record.dart';

@immutable
abstract class MedicineState {}

class MedicineInitial extends MedicineState {}

class MedicineLoading extends MedicineState {}

class MedicineLoaded extends MedicineState {
  final List<MedicineRecord> medicines;

  MedicineLoaded(this.medicines);
}

class MedicineError extends MedicineState {
  final String message;

  MedicineError(this.message);
}
