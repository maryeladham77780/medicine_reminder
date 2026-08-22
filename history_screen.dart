import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/medicine_history_cubit.dart';
import '../cubit/medicine_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MedicineHistoryCubit()..fetchMedicineHistory(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Medicine History'),
          centerTitle: true,
        ),
        body: BlocBuilder<MedicineHistoryCubit, MedicineHistoryState>(
          builder: (context, state) {
            if (state is MedicineHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MedicineHistoryEmpty) {
              return const Center(
                child: Text(
                  'No Medicine Records Found',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            if (state is MedicineHistoryError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            }

            if (state is MedicineHistoryLoaded) {
              return RefreshIndicator(
                onRefresh: () =>
                    context.read<MedicineHistoryCubit>().fetchMedicineHistory(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.records.length,
                  itemBuilder: (context, index) {
                    final record = state.records[index];

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),

                        leading: const CircleAvatar(
                          radius: 25,
                          child: Icon(
                            Icons.medication,
                            size: 30,
                          ),
                        ),

                        title: Text(
                          record.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.medication_outlined,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(record.dose),
                                ],
                              ),

                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(record.dateTime),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}