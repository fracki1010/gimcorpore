import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getMuscles() async {
  List muscles = [];

  CollectionReference collectionReferenceMuscles = db.collection('muscles');

  //si son muchos no hacer un get es una consulta basica
  QuerySnapshot queryMuscles = await collectionReferenceMuscles.get();

  queryMuscles.docs.forEach((doc) {
    muscles.add(doc.data());
  });

  await Future.delayed(const Duration(seconds: 3));

  return muscles;
}
