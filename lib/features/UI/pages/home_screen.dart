import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_app/features/UI/widgets/add_habit_text_field.dart';
import 'package:habit_tracker_app/features/UI/widgets/custom_app_bar.dart';
import 'package:habit_tracker_app/features/UI/widgets/habit_counter.dart';
import 'package:habit_tracker_app/features/UI/widgets/habit_list.dart';
import 'package:habit_tracker_app/features/UI/widgets/no_habits.dart';
import 'package:habit_tracker_app/features/providers/habit_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController? _habitController;

  final FocusNode _focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    _habitController = TextEditingController();
    _focusNode.addListener(() {
    });
  }

  @override
  void dispose() {
    _habitController?.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habits = ref.watch(habitProvider);
    final habitCount = habits.length;
    int count = ref.watch(habitProvider.notifier).doneCount();


    return Scaffold(
      backgroundColor: Color(0xffF8F7F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Center(
            child: Column(
              children: [
                CustomAppBar(),
                (count==0)? SizedBox.shrink():  HabitCounter(),
                (habitCount == 0) ? NoHabits(controller: _habitController!,focusNode: _focusNode,) : HabitList(controller: _habitController!,focusNode: _focusNode,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
