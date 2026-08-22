import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/medicine_record.dart';
import 'medicine_state.dart';

class MedicineHistoryCubit extends Cubit<MedicineHistoryState> {
  MedicineHistoryCubit() : super(MedicineHistoryInitial());

  Future<void> fetchMedicineHistory() async {
    emit(MedicineHistoryLoading());

    try {
      final List<MedicineRecord> dummyData = [
        MedicineRecord(
          id: '1',
          name: 'Panadol Extra',
          dose: '500 mg - 2 Pills',
          dateTime: '2026-08-21 08:00 AM',
        ),
        MedicineRecord(
          id: '2',
          name: 'Vitamin C',
          dose: '1000 mg - 1 Tablet',
          dateTime: '2026-08-21 02:00 PM',
        ),
      ];

      emit(MedicineHistoryLoaded(dummyData));
    } catch (e) {
      emit(MedicineHistoryError(e.toString()));
    }
  }
}