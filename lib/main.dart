import 'package:flutter/material.dart';
import 'package:tea_assignment/core/theme/app_theme.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:io';
import 'package:window_manager/window_manager.dart';
import 'package:tea_assignment/features/add_emotion/screens/add_emotion_screen.dart';
import 'package:tea_assignment/features/add_task/screens/add_task_screen.dart';
import 'package:tea_assignment/features/add_thoughts/screens/add_thoughts_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(393, 900),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'TEA Assignment',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const TestHomeScreen(),
        );
      },
    );
  }
}

class TestHomeScreen extends StatelessWidget {
  const TestHomeScreen({super.key});

  void _showSheet(BuildContext context, Widget sheet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 0.85.sh,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        clipBehavior: Clip.antiAlias,
        child: sheet,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TaskCreationScreen(),
                ),
              ),
              child: const Text("Create Task"),
            ),
            SizedBox(height: 20.h),
            TextButton(
              onPressed: () => _showSheet(context, const AddEmotionSheet()),
              child: const Text("Add Emotion"),
            ),
            SizedBox(height: 20.h),
            TextButton(
              onPressed: () => _showSheet(context, const AddThoughtsSheet()),
              child: const Text("Add Thoughts"),
            ),
          ],
        ),
      ),
    );
  }
}
