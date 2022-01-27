import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_pups/database/models/pup.dart';

class PupsRepository {
  final CollectionReference _pupsCollection =
      FirebaseFirestore.instance.collection('pups');

  Future<List<Pup>> loadWeightees() async {
    QuerySnapshot querySnapshot = await _pupsCollection.get();
    return querySnapshot.docs
        .map(
          (doc) => Pup(
            name: doc['time'],
            breed: doc['weight'],
            age: doc['age'],
            isSelected: doc['isSelected'],
          ),
        )
        .toList();
  }
}
