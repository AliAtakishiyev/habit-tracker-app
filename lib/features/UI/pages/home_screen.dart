import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_app/features/UI/widgets/custom_app_bar.dart';
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
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _habitController = TextEditingController();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focused = true;
      } else {
        _focused = false;
      }
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

    return Scaffold(
      backgroundColor: Color(0xffF8F7F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Center(
            child: Column(
              children: [
                CustomAppBar(),

                TextField(
                  controller: _habitController,
                  focusNode: _focusNode,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _focused
                              ? Color(0xffA8CAB7)
                              : Color(0xffD3D2D4),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Color(0xffF8F7F0),
                          radius: 4,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 24),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Color(0xffA8CCB5)),
                    ),
                    suffixIcon: _habitController!.text.isEmpty
                        ? SizedBox()
                        : SizedBox(
                            width: 80,
                            height: 55,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final alreadyExisted = habits.any(
                                    (habit) =>
                                        habit.name!.toLowerCase() ==
                                        _habitController!.text.toLowerCase(),
                                  );
                                  if (alreadyExisted) {
                                    print("nah bro");
                                  } else {
                                    await ref
                                        .read(habitProvider.notifier)
                                        .addHabit(_habitController!.text);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(0, 32),
                                  backgroundColor: Color(0xff4B9B73),
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: .bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),

                (habitCount == 0) ? NoHabits() : HabitList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
