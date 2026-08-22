
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'database/medicine_db.dart';
import 'models/medicine_record.dart';
import 'cubit/medicine_cubit.dart';
import 'screens/history_screen.dart';
import 'screens/add_screen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
 
  // تشغيل قاعدة البيانات
  await MedicineDB.init();
 
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    // BlocProvider واحد فوق كل التطبيق عشان AddScreen و HistoryScreen
    // يشتغلوا على نفس الـ Cubit ونفس البيانات الحقيقية من Hive
    return BlocProvider(
      create: (context) => MedicineCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medicine Tracker',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2F6FB3),
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: const Color(0xFFF6F9FC),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF6F9FC),
            foregroundColor: Color(0xFF1E293B),
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home: const MainWrapper(),
      ),
    );
  }
}
 
class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HistoryScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMedicineScreen(
                onSave: (recordData) {
                  final record = MedicineRecord(
                    name: recordData['name'] as String,
                    dose: recordData['dose'] as String,
                    dateTime: recordData['dateTime'] as String,
                  );
                  // بنستخدم نفس الـ context (تبع MainWrapper) عشان
                  // نوصل لنفس الـ MedicineCubit المزوّد فوق
                  context.read<MedicineCubit>().addMedicine(record);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
 
