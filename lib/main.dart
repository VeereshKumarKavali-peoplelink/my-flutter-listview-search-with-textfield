import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //useMaterial3: true,
      ),
      home: const MyHomePage(title: "ListView Search"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //const MyHomePage({super.key, required String title});
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 38},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  void initState() {
    _foundUsers = _allUsers;
    super.initState();
  }


  void _runFilter(String enteredKeyword){
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty){
      results = _allUsers;
    }else{
      results = _allUsers.where((user) => user["name"].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            const SizedBox(height: 20),
             TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                labelText: "Search", suffixIcon: Icon(Icons.search)
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  itemCount: _foundUsers.length,
                  itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundUsers[index]["id"]),
                      color: Colors.purple,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                          leading: Text(_foundUsers[index]["id"].toString(),
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.white)),
                          title: Text(_foundUsers[index]["name"].toString(),
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(
                              '${_foundUsers[index]["age"].toString()} years old',
                              style: const TextStyle(color: Colors.white))))),
            ),
          ]),
        ));
  }
}
