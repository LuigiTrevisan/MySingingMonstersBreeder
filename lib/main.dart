import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'list.dart';
import 'teste.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Singing Monsters Combiner',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.robotoCondensed().fontFamily,
      ),
      home: const MyHomePage(
          title: 'My Singing Monsters Combiner (v0.0.280823.2)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? counter = '';
  String? combo = '';
  List<String> monsters = getLista();
  String? selectedMonster1;
  String? selectedMonster2;
  String? selectedResult;
  String? resposta;
  List<List<String>>? listCombo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        ),
      ),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            const Text(
              'Selecione os monstros:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              children: [
                DropdownButton(
                  hint: const Text(
                    'Escolha o primeiro monstro',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: selectedMonster1,
                  items: monsters.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedMonster1 = value;
                    });
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                DropdownButton(
                  hint: const Text(
                    'Escolha o segundo monstro',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: selectedMonster2,
                  items: monsters.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonster2 = newValue!;
                    });
                  },
                ),
              ],
            ),
            Wrap(
              children: [
                IconButton(
                    //Botão de combinar
                    onPressed: () {
                      resposta =
                          monsterSearch(selectedMonster1, selectedMonster2);
                      setState(() {
                        counter = resposta;
                      });
                    },
                    icon: const Icon(Icons.search),
                    padding: const EdgeInsets.all(10),
                    iconSize: 50),
                IconButton(
                    //Botão de limpar
                    onPressed: () {
                      setState(() {
                        selectedMonster1 = null;
                        selectedMonster2 = null;
                        selectedResult = null;
                        combo = '';
                        counter = '';
                        
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    padding: const EdgeInsets.all(10),
                    iconSize: 50),
              ],
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            DropdownButton(
              hint: const Text(
                'Escolha o resultado',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              value: selectedResult,
              items: monsters.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedResult = newValue!;
                });
              },
            ),
            IconButton(
                onPressed: () {
                  listCombo = comboSearch(selectedResult);
                  setState(() {
                    combo = '';
                    for (var i = 0; i < listCombo!.length; i++) {
                      combo =
                          '${combo!}${listCombo![i][0]} e ${listCombo![i][1]}\n';
                    }
                  });
                },
                icon: const Icon(Icons.search),
                padding: const EdgeInsets.all(10),
                iconSize: 50),
            Text(
              '$combo',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ]),
    );
  }
}
