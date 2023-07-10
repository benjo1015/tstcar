import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  runApp(
    const MainPage(),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dance List',
      home: DanceListPage(),
    );
  }
}

class DanceListPage extends StatefulWidget {
  final List _steps = [];

  @override
  State<DanceListPage> createState() => _DanceListPageState();
}

class _DanceListPageState extends State<DanceListPage> {
  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/dance.json');
    final data = await json.decode(response);

    setState(() {
      _items = data;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dance list',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dance List"),
        ),
        body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            final selector = DanceStepImageSelector();
            final stepenumerator = DanceStepEnumerator();
            return ExpansionTile(
                title: Row(children: [
                  Image.asset(selector.getImagePath(item["name"]), width: 50),
                  Text(item["name"],
                      style: Theme.of(context).textTheme.headlineSmall)
                ]),
                subtitle: Text(item["category"]),
                children: stepenumerator.getListSteps(item));
          },
        ),
      ),
    );
  }
}

class DanceStepEnumerator {
  List<ListTile> getListSteps(dynamic item) {
    var list = item["danceSteps"];
    var result = <ListTile>[];
    for (int i = 0; i < list.length; i++) {
      result.add(ListTile(
          title: Text(list[i]["name"]), subtitle: Text(list[i]["type"])));
    }
    return result;
  }
}

class DanceStepImageSelector {
  String getImagePath(String name) {
    switch (name) {
      case "ChaChaCha":
        return 'assets/chachacha.png';
      case "Rhumba":
        return 'assets/rhumba.png';
      case "Paso Doble":
        return 'assets/pasodoble.png';
      case "Jive":
        return 'assets/jive.png';
      case "Samba":
        return 'assets/samba.png';
      case "Waltz":
        return 'assets/waltz.png';
      case "Tango":
        return 'assets/tango.png';
      case "QuickStep":
        return 'assets/quickstep.png';
      case "Foxtrot":
        return 'assets/foxtrot.png';
      case "VienneseWaltz":
        return 'assets/viennesewaltz.png';
      default:
        return 'assets/chachacha.png';
    }
  }
}
