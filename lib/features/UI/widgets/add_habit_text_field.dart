import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_app/features/providers/habit_provider.dart';

class AddHabitTextField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const AddHabitTextField({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  ConsumerState<AddHabitTextField> createState() => _AddHabitTextFieldState();
}

class _AddHabitTextFieldState extends ConsumerState<AddHabitTextField> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final focusNode = widget.focusNode;
    final habits = ref.watch(habitProvider);
    final focused = focusNode.hasFocus;

    return TextField(
      controller: controller,
      focusNode: focusNode,
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
              color: focused ? Color(0xffA8CAB7) : Color(0xffD3D2D4),
            ),
            child: CircleAvatar(
              backgroundColor: Color(0xffF8F7F0),
              radius: 4,
              child: Icon(Icons.add),
            ),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 24),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xffA8CCB5)),
        ),
        suffixIcon: controller!.text.isEmpty
            ? SizedBox()
            : SizedBox(
                width: 80,
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final habitName = controller.text.toString();

                      final alreadyExisted = habits.any(
                        (habit) =>
                            habit.name!.toLowerCase() ==
                            controller.text.toLowerCase(),
                      );
                      if (alreadyExisted) {
                        

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "The habit “$habitName already exists.",
                            ),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        await ref
                            .read(habitProvider.notifier)
                            .addHabit(controller.text);
                        controller.clear();
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
                      style: TextStyle(color: Colors.white, fontWeight: .bold),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
