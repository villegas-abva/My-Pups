import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_pups/database/models/pup/pup.dart';

class PupCRUDOperations {
  final CollectionReference _pupsCollection =
      FirebaseFirestore.instance.collection('pups');

  Future<List<Pup>> loadPups() async {
    QuerySnapshot querySnapshot = await _pupsCollection.get();
    return querySnapshot.docs
        .map(
          (doc) => Pup(
            name: doc['name'],
            sex: doc['sex'],
            breed: doc['breed'],
            age: doc['age'],
            owner: doc['owner'],
            imageUrl: doc['imageUrl'],
            hasClinic: doc['hasClinic'],
            petClinic: doc['petClinic'],
            vetName: doc['vetName'],
            vetNotes: doc['vetNotes'],
            lastVisit: doc['lastVisit'],
            nextVisit: doc['nextVisit'],
            id: doc['id'],
          ),
        )
        .toList();
  }

  /// Note: "set" allows you to select the specific custom Id for document
  /// '"Add" creates a random docuement id
  Future addPup({required Pup pup}) async {
    try {
      final docId = _pupsCollection.doc().id;
      await _pupsCollection.doc(docId).set({
        'name': pup.name,
        'sex': pup.sex,
        'breed': pup.breed,
        'age': pup.age,
        'owner': pup.owner,
        'hasClinic': pup.hasClinic,
        'petClinic': pup.petClinic,
        'vetName': pup.vetName,
        'vetNotes': pup.vetNotes,
        'lastVisit': pup.lastVisit,
        'nextVisit': pup.nextVisit,
        'imageUrl': pup.imageUrl,
        'id': docId,
      });
    } catch (e) {}
  }

  Future deletePup(String id) async {
    try {
      await _pupsCollection.doc(id).delete();
    } catch (e) {}
  }

  Future editPup({required Pup pup})
// TODO: Optimize / just change specific values

  async {
    // TODO: edit image
    try {
      _pupsCollection.doc(pup.id).update({
        'name': pup.name,
        'sex': pup.sex,
        'breed': pup.breed,
        'age': pup.age,
        'owner': pup.owner,
        'hasClinic': pup.hasClinic,
        'petClinic': pup.petClinic,
        'vetName': pup.vetName,
        'vetNotes': pup.vetNotes,
        'lastVisit': pup.lastVisit,
        'nextVisit': pup.nextVisit,
        'imageUrl': pup.imageUrl,
        'id': pup.id,
      });
    } catch (e) {}
  }

  Stream<List<Pup>> getAllPups() {
    return _pupsCollection.snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) => Pup.pupFromSnapshot(doc)).toList();
      },
    );
  }
}
