import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/todo_controller.dart';
import '../../data/models/todo_model.dart';

class AddEditTodoView extends StatelessWidget {
  final TodoController todoController = Get.find();
  final Todo? todo;

  AddEditTodoView({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController =
        TextEditingController(text: todo?.title ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          todo == null ? 'Add Todo' : 'Edit Todo',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Task Name",style: GoogleFonts.roboto(
                    fontSize: 16.0,
                    // Adjust the font size as needed
                    fontWeight: FontWeight.w400, // Adjust the font weight as needed
                  ),),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3556AB),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xff0D2972), width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {
                  final title = textEditingController.text;
                  if (title.isNotEmpty) {
                    if (todo == null) {
                      // Add a new todo
                      todoController.addOrUpdate(Todo(
                        id: todoController.todos.isEmpty
                            ? 1
                            : todoController.todos.length + 1,
                        title: title,
                      ));
                    } else {
                      // Update an existing todo
                      todoController.addOrUpdate(todo!.copyWith(title: title));
                    }
                    Get.back(); // Go back to the previous screen
                  } else {
                    // Show an error or handle empty title
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    todo == null ? 'Add Todo' : 'Update Todo',
                    style: GoogleFonts.roboto(
                      fontSize: 18.0,
                      color: Colors.white,
                      // Adjust the font size as needed
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
