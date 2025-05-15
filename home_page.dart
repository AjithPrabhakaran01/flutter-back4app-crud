import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  List<ParseObject> items = [];

  @override
  void initState() {
    super.initState();
    getRecords();
  }

  void getRecords() async {
    final query = QueryBuilderParseObject(ParseObject('Person'));
    final response = await query.find();

    if (response.success && response.results != null) {
      setState(() {
        items = response.results!;
      });
    }
  }

  void addRecord() async {
    if (int.tryParse(ageController.text) == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Age must be numeric')));
      return;
    }

    final person =
        ParseObject('Person')
          ..set('name', nameController.text)
          ..set('age', int.parse(ageController.text) as String);
    await person.save();
    getRecords();
  }

  void updateRecord(ParseObject object) async {
    object
      ..set('name', nameController.text)
      ..set('age', int.parse(ageController.text) as String);
    await object.save();
    getRecords();
  }

  void deleteRecord(ParseObject object) async {
    await object.delete();
    getRecords();
  }

  Widget buildItem(ParseObject object) {
    final name = object.get("name") ?? "";
    final age = object.get('age') ?? 0;
    return ListTile(
      title: Text('$name (Age: $age)'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              nameController.text = name;
              ageController.text = age.toString();
              updateRecord(object);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => deleteRecord(object),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CRUD with Back4App")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addRecord,
              child: const Text('Add Record'),
            ),
            const Divider(),
            Expanded(child: ListView(children: items.map(buildItem).toList())),
          ],
        ),
      ),
    );
  }
}

class QueryBuilderParseObject {
  QueryBuilderParseObject(ParseObject parseObject);

  find() {}
}

class QueryBuilder {
  QueryBuilder(ParseObject object);

  find() {}
}

class ParseObject {
  ParseObject(String s);

  set(String s, String text) {}

  save() {}

  delete() {}

  get(String s) {}
}
