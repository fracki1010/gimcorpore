import 'package:flutter/material.dart';

//importaciones de firestore
import 'package:firebase_core/firebase_core.dart';

//servicios
import 'package:gimnasio_corporesano/config/services/firebase_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({
    super.key,
  });

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gimnasio Corpore sano'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getMuscles(),
          builder: (context, snapshot) {
            //Esto es porque por un nano segundo no hay data entonces muestra un null
            //con este if se resuelve el problema
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data?[index]['name']),
                );
              },
              itemCount: snapshot.data?.length,
            );
          },
        ));
  }
}
