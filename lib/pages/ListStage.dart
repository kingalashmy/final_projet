// import 'package:flutter/material.dart';
// import 'package:login_page/compenants/MyButton.dart';
// import 'package:login_page/sqldb.dart';

// class ListStage extends StatefulWidget {
//   final Map<String, dynamic> userData;
//   ListStage({Key? key, required this.userData}) : super(key: key);

//   @override
//   _ListStageState createState() => _ListStageState();
// }

// class _ListStageState extends State<ListStage> {
//   String insertionResult = '';
//   late SqlDb db; // Déclarez db comme variable de classe

//   @override
//   void initState() {
//     super.initState();
//     initializeDatabase(); // Appeler la méthode pour initialiser la base de données
//   }

//   void initializeDatabase() async {
//     db = SqlDb();
//     await db.intialDb(); // Attendre que la base de données soit initialisée
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Suivre Stage'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             MyButton(
//               TextButton: "Create Stage",
//               ButtonColor: Colors.orange,
//               onPressed: () async{
//                 int response = await db.insertData('''
//                   INSERT INTO Stages (Sujet_Stage, Lieu_Stage, Type_Stage, id_Professeur, email_Etudiant)
//                   VALUES('stage_1', 'tanger', 'web', 1 , 'm.alhamed@gamil.com')
//                 ''');
//                 print(response);
//               },
//             ),
//             MyButton(
//               TextButton: "Show Stage",
//               ButtonColor: Colors.blue,
//               onPressed: () async{
//                 List<Map> response = await db.readData("SELECT * FROM 'Stages' ");
//                 print("$response");
//               },
//             ),

//           ],
//         ),
//       ),
//     );
//   }
// }





// -----------------------------------------------------------------------------------------------------
// -------------------------   codes correct -----------------------------------------------------------
// -----------------------------------------------------------------------------------------------------




// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_final_fields

// import 'package:flutter/material.dart';
// import 'package:login_page/compenants/MyButton.dart';
// import 'package:login_page/sqldb.dart';

// // Constants
// const Color tdRed = Color(0xFFDA4040);
// const Color tdBlue = Color(0xFF5F52EE);
// const Color tdBlack = Color(0xFF3A3A3A);
// const Color tdGrey = Color(0xFF717171);
// const Color tdBGColor = Color(0xFFEEEFF5);

// // Model
// class ToDo {
//   String? id;
//   String? todoText;
//   bool isDone;

//   ToDo({
//     required this.id,
//     required this.todoText,
//     this.isDone = false,
//   });

//   static List<ToDo> todoList() {
//     return [
//       ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
//       ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
//       ToDo(id: '03', todoText: 'Check Emails'),
//       ToDo(id: '04', todoText: 'Team Meeting'),
//       ToDo(id: '05', todoText: 'Work on mobile apps for 2 hours'),
//       ToDo(id: '06', todoText: 'Dinner with Jenny'),
//     ];
//   }
// }

// // Widget
// class ListStage extends StatefulWidget {
//   final Map<String, dynamic> userData; // Ajouter le paramètre userData
//   ListStage({Key? key, required this.userData}) : super(key: key);

//   @override
//   State<ListStage> createState() => _ListStageState();
// }

// class _ListStageState extends State<ListStage> {
//   final List<ToDo> todosList = ToDo.todoList();
//   List<ToDo> _foundToDo = [];
//   final _todoController = TextEditingController();
//   SqlDb db = SqlDb();

//   TextEditingController _sujetController = TextEditingController();
//   TextEditingController _lieuController = TextEditingController();
//   TextEditingController _typeController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();

//   bool _showTextField = false;

//   @override
//   void initState() {
//     _foundToDo = todosList;
//     super.initState();
//     _fetchStagesFromDatabase();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: tdBGColor,
//       appBar: _buildAppBar(),
//       body: Stack(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 15,
//             ),
//             child: Column(
//               children: [
//                 searchBox(),
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(
//                           top: 50,
//                           bottom: 20,
//                         ),
//                         child: Text(
//                           'Liste Inter',
//                           style: TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       for (ToDo todo in _foundToDo.reversed)
//                         _ToDoItem(
//                           todo: todo,
//                           onToDoChanged: _handleToDoChange,
//                           onDeleteItem: _deleteToDoItem,
//                         ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: _buildTextField(),
//                 ),
//                 _buildButtonRow(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField() {
//     return _showTextField
//         ? Container(
//             margin: EdgeInsets.only(
//               bottom: 20,
//               right: 20,
//               left: 20,
//             ),
//             padding: EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 5,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.grey,
//                   offset: Offset(0.0, 0.0),
//                   blurRadius: 10.0,
//                   spreadRadius: 0.0,
//                 ),
//               ],
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _sujetController,
//                   decoration: InputDecoration(
//                     hintText: 'Title',
//                     border: InputBorder.none,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: _lieuController,
//                   decoration: InputDecoration(
//                     hintText: 'Location',
//                     border: InputBorder.none,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: _typeController,
//                   decoration: InputDecoration(
//                     hintText: 'Type',
//                     border: InputBorder.none,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     hintText: 'Email',
//                     border: InputBorder.none,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: _insertNewStage,
//                   child: Text('Créer'),
//                 ),
//                 SizedBox(height: 10),
//                 MyButton(
//                   TextButton: "Show ",
//                   ButtonColor: Color.fromARGB(255, 140, 177, 206),
//                   onPressed: () async {
//                       List<Map> response = await db.readData("SELECT * FROM 'Stages' ");
//                       // ignore: avoid_print
//                       print("$response");
//                     _fetchStagesFromDatabase();
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 MyButton(
//                   TextButton: "Annuler",
//                   ButtonColor: Color.fromARGB(255, 140, 177, 206),
//                   onPressed: () {
//                     setState(() {
//                       _showTextField = false;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           )
//         : SizedBox.shrink();
//   }

//   Widget _buildButtonRow() {
//     return Container(
//       margin: EdgeInsets.only(
//         bottom: 20,
//         right: 20,
//       ),
//       child: ElevatedButton(
//         child: Text(
//           '+',
//           style: TextStyle(
//             fontSize: 40,
//           ),
//         ),
//         onPressed: () {
//           setState(() {
//             _showTextField = true;
//           });
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: tdBlue,
//           minimumSize: Size(60, 60),
//           elevation: 10,
//         ),
//       ),
//     );
//   }

//   void _handleToDoChange(ToDo todo) {
//     setState(() {
//       todo.isDone = !todo.isDone;
//     });
//   }

//   void _deleteToDoItem(String id) {
//     setState(() {
//       todosList.removeWhere((item) => item.id == id);
//     });
//   }

//   void _insertNewStage() async {
//     await db.insertData('''
//       INSERT INTO Stages (Sujet_Stage, Lieu_Stage, Type_Stage, id_Professeur, email_Etudiant)
//       VALUES('${_sujetController.text}', '${_lieuController.text}', '${_typeController.text}', 1 , '${_emailController.text}')
//     ''');
//     _fetchStagesFromDatabase(); // Fetch stages after inserting new stage
//   }

//   void _fetchStagesFromDatabase() async {
//     List<Map> response = await db.readData("SELECT * FROM 'Stages' ");
//     setState(() {
//       _foundToDo = response.map((stage) {
//         return ToDo(
//           id: stage['id'].toString(),
//           todoText: stage['Sujet_Stage'].toString(),
//           isDone: false, // You can set the isDone flag based on your logic
//         );
//       }).toList();
//     });
//   }

//   void _runFilter(String enteredKeyword) {
//     List<ToDo> results = [];
//     if (enteredKeyword.isEmpty) {
//       results = todosList;
//     } else {
//       results = todosList
//           .where(
//             (item) => item.todoText!
//                 .toLowerCase()
//                 .contains(enteredKeyword.toLowerCase()),
//           )
//           .toList();
//     }

//     setState(() {
//       _foundToDo = results;
//     });
//   }

//   Widget searchBox() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: TextField(
//         onChanged: (value) => _runFilter(value),
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.all(0),
//           prefixIcon: Icon(
//             Icons.search,
//             color: tdBlack,
//             size: 20,
//           ),
//           prefixIconConstraints: BoxConstraints(
//             maxHeight: 20,
//             minWidth: 25,
//           ),
//           border: InputBorder.none,
//           hintText: 'Search',
//           hintStyle: TextStyle(color: tdGrey),
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: tdBGColor,
//       elevation: 0,
//       title: Text("Liste des stages"),
//     );
//   }
// }

// class _ToDoItem extends StatelessWidget {
//   final ToDo todo;
//   final Function(ToDo) onToDoChanged;
//   final Function(String) onDeleteItem;

//   const _ToDoItem({
//     required this.todo,
//     required this.onToDoChanged,
//     required this.onDeleteItem,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20),
//       child: ListTile(
//         onTap: () {
//           onToDoChanged(todo);
//         },
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//         tileColor: Colors.white,
//         title: Text(
//           todo.todoText!,
//           style: TextStyle(
//             fontSize: 16,
//             color: tdBlack,
//             decoration: todo.isDone ? TextDecoration.lineThrough : null,
//           ),
//         ),
//         trailing: Container(
//           padding: EdgeInsets.all(0),
//           margin: EdgeInsets.symmetric(vertical: 12),
//           height: 35,
//           width: 35,
//           decoration: BoxDecoration(
//             color: tdRed,
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: IconButton(
//             color: Colors.white,
//             iconSize: 18,
//             icon: Icon(Icons.delete),
//             onPressed: () {
//               onDeleteItem(todo.id!);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }



//  ---------------------------------------
//                    autre version de codes
//  ---------------------------------------



// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:login_page/compenants/MyButton.dart';
import 'package:login_page/sqldb.dart';

// Constants
const Color tdRed = Color(0xFFDA4040);
const Color tdBlue = Color(0xFF5F52EE);
const Color tdBlack = Color(0xFF3A3A3A);
const Color tdGrey = Color(0xFF717171);
const Color tdBGColor = Color(0xFFEEEFF5);

// Model
class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
      ToDo(id: '03', todoText: 'Check Emails'),
      ToDo(id: '04', todoText: 'Team Meeting'),
      ToDo(id: '05', todoText: 'Work on mobile apps for 2 hours'),
      ToDo(id: '06', todoText: 'Dinner with Jenny'),
    ];
  }
}

// Widget
class ListStage extends StatefulWidget {
  final Map<String, dynamic> userData; // Ajouter le paramètre userData
  ListStage({Key? key, required this.userData}) : super(key: key);

  @override
  State<ListStage> createState() => _ListStageState();
}

class _ListStageState extends State<ListStage> {
  final List<ToDo> todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  // ignore: unused_field
  final _todoController = TextEditingController();
  SqlDb db = SqlDb();

  TextEditingController _sujetController = TextEditingController();
  TextEditingController _lieuController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _showTextField = false;

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
    _fetchStagesFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'Liste Inter',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todo in _foundToDo.reversed)
                        _ToDoItem(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: _buildTextField(),
                ),
                _buildButtonRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return _showTextField
        ? Container(
            margin: EdgeInsets.only(
              bottom: 20,
              right: 20,
              left: 20,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _sujetController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _lieuController,
                  decoration: InputDecoration(
                    hintText: 'Location',
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _typeController,
                  decoration: InputDecoration(
                    hintText: 'Type',
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _insertNewStage,
                  child: Text('Créer'),
                ),
                SizedBox(height: 10),
                MyButton(
                  TextButton: "Show ",
                  ButtonColor: Color.fromARGB(255, 140, 177, 206),
                  onPressed: () async {
                      List<Map> response = await db.readData("SELECT * FROM 'Stages' ");
                      // ignore: avoid_print
                      print("$response");
                    _fetchStagesFromDatabase();
                  },
                ),
                SizedBox(height: 10),
                MyButton(
                  TextButton: "Annuler",
                  ButtonColor: Color.fromARGB(255, 140, 177, 206),
                  onPressed: () {
                    setState(() {
                      _showTextField = false;
                    });
                  },
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }

  Widget _buildButtonRow() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
        right: 20,
      ),
      child: ElevatedButton(
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        onPressed: () {
          setState(() {
            _showTextField = true;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: tdBlue,
          minimumSize: Size(60, 60),
          elevation: 10,
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) async {
    await db.deleteData("DELETE FROM 'Stages' WHERE id = '$id'");
    _fetchStagesFromDatabase(); // Fetch stages after deleting stage
  }

  void _insertNewStage() async {
    await db.insertData('''
      INSERT INTO Stages (Sujet_Stage, Lieu_Stage, Type_Stage, id_Professeur, email_Etudiant)
      VALUES('${_sujetController.text}', '${_lieuController.text}', '${_typeController.text}', 1 , '${_emailController.text}')
    ''');
    _fetchStagesFromDatabase(); // Fetch stages after inserting new stage
  }

  void _fetchStagesFromDatabase() async {
    List<Map> response = await db.readData("SELECT * FROM 'Stages' ");
    setState(() {
      _foundToDo = response.map((stage) {
        return ToDo(
          id: stage['id'].toString(),
          todoText: stage['Sujet_Stage'].toString(),
          isDone: false, // You can set the isDone flag based on your logic
        );
      }).toList();
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where(
            (item) => item.todoText!
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()),
          )
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Text("Liste des stages"),
    );
  }
}

class _ToDoItem extends StatelessWidget {
  final ToDo todo;
  final Function(ToDo) onToDoChanged;
  final Function(String) onDeleteItem;

  const _ToDoItem({
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(todo.id!);
            },
          ),
        ),
      ),
    );
  }
}
