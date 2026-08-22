import 'package:flutter/foundation.dart';

import '../models/medicine_record.dart';

// ================= Medicine States =================

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

// ============== Medicine History States ==============

@immutable
abstract class MedicineHistoryState {}

class MedicineHistoryInitial extends MedicineHistoryState {}

class MedicineHistoryLoading extends MedicineHistoryState {}

class MedicineHistoryLoaded extends MedicineHistoryState {
  final List<MedicineRecord> records;

  MedicineHistoryLoaded(this.records);
}

class MedicineHistoryEmpty extends MedicineHistoryState {}

class MedicineHistoryError extends MedicineHistoryState {
  final String message;

  MedicineHistoryError(this.message);
}