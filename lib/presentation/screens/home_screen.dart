import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/todo_controller.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddEditTodoView(
              todo: null)); // Navigate to AddEditTodoView to add a new task
        },
        shape:
            const CircleBorder(side: BorderSide(color: Color(0xFF123EB1), width: 2)),
        backgroundColor: const Color(0xff3556AB),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        toolbarHeight:
            MediaQuery.of(context).size.height * 0.20, // Set this height
        flexibleSpace: SafeArea(
          child: Container(
            color: const Color(0xff3556AB),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/profile.png"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hello John', style: GoogleFonts.roboto(
                  fontSize: 16.0,
                  color: Colors.white,
                  // Adjust the font size as needed
                  fontWeight: FontWeight.w500, // Adjust the font weight as needed
                ),),
                    Text('What are your plans \n for today?',style: GoogleFonts.roboto(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w100
                    ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xffCDE53D),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff9EB031),
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.15,
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/award.png"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Go Pro (No Ads)",style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            color: const Color(0xff071D55),
                            // Adjust the font size as needed
                            fontWeight: FontWeight.bold, // Adjust the font weight as needed
                          ),),
                          Text("No fuss, no ads, for only \$1 a month",style: GoogleFonts.roboto(
                            fontSize: 12.0,
                            color: const Color(0xff0D2972),
                          ),)
                        ],
                      )
                    ],
                  ),
                  Positioned(
                  right: 10,
                  top: 0
                  ,child: Container(
                    height: 50,
                    width: 50,
                    color: const Color(0xff071D55),
                    child: Center(
                      child: Text("\$1",style: GoogleFonts.roboto(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.yellow,
                      ),),
                    ),
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            todoController.todos.isEmpty
                ? Image.asset("assets/empty.jpeg")
                : Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: todoController.todos.length,
                      itemBuilder: (context, index) {
                        final todo = todoController.todos[index];
                        return Dismissible(
                          key: Key(todo.id.toString()),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            child: const Icon(Icons.delete, color: Color(0xff3556AB)),
                          ),
                          onDismissed: (direction) {
                            todoController.delete(todo); // Delete the task from the list
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                                child: ListTile(
                                  title: Text(
                                    todo.title,
                                    style:GoogleFonts.roboto(
                                      decoration: todo.isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                        fontSize: 16.0,
                                        color: todo.isCompleted
                                            ?const Color(0xff8D8D8D):const Color(0xff071D55),
                                        fontWeight: FontWeight.w500
                                    )
                                  ),
                                  leading: Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: Colors.white,
                                    ),
                                    child: Transform.scale(
                                      scale: 1.2,
                                      child: Checkbox(
                                        value: todo.isCompleted,
                                        checkColor: const Color(0xff49C25D),
                                        activeColor: const Color(0xff53DA69),
                                        shape: const CircleBorder(
                                            side: BorderSide(
                                          color: Color(0xff49C25D),
                                          width: 2,
                                        )),
                                        splashRadius: 20,
                                        onChanged: (value) {
                                          final updatedTodo = todo.copyWith(
                                              isCompleted: value ?? false);
                                          todoController.addOrUpdate(updatedTodo);
                                        },
                                      ),
                                    ),
                                  ),
                                  trailing: RawMaterialButton(
                                    onPressed: () {
                                      Get.to(() => AddEditTodoView(
                                          todo:
                                              todo)); // Navigate to AddEditTodoView to add a new task
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: const BorderSide(
                                            color: Color(0xff071D55), width: 1)),
                                    child:  Text(
                                      "Edit",
                                      style: GoogleFonts.roboto(
                                          fontSize: 16.0,
                                          color: const Color(0xff071D55),
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
          ],
        ),
      ),
    );
  }
}
