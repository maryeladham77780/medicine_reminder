import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/medicine_db.dart';
import '../models/medicine_record.dart';
import 'medicine_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  MedicineCubit() : super(MedicineInitial()) {
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    emit(MedicineLoading());

    try {
      final List<MedicineRecord> data =
          MedicineDB.getAllRecords();

      emit(MedicineLoaded(data));
    } catch (e) {
      emit(MedicineError(e.toString()));
    }
  }

  Future<void> addMedicine(MedicineRecord newMedicine) async {
    await MedicineDB.insertRecord(newMedicine);
    await fetchMedicines();
  }

  Future<void> deleteMedicine(dynamic key) async {
    await MedicineDB.deleteRecord(key);
    await fetchMedicines();
  }
}