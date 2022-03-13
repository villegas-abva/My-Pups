import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_pups/database/models/pup.dart';

class PupsRepository {
  final CollectionReference _pupsCollection =
      FirebaseFirestore.instance.collection('pups');

  Future<List<Pup>> loadPups() async {
    QuerySnapshot querySnapshot = await _pupsCollection.get();
    return querySnapshot.docs
        .map(
          (doc) => Pup(
            name: doc['name'],
            breed: doc['breed'],
            age: doc['age'],
            isSelected: doc['isSelected'],
            imageUrl: doc['image_url'],
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
      print('docId: $docId');
      await _pupsCollection.doc(docId).set({
        // 'age': 1,
        'age': pup.age,
        // 'breed': 'Unknown',
        'breed': pup.breed,
        'id': docId,
        'image_url':
            'https://firebasestorage.googleapis.com/v0/b/my-pups-36a9a.appspot.com/o/my_pups%2Fdog_incognito.jpg.webp?alt=media&token=9b92f4eb-ee0b-4bd2-b3a7-c8e35608caee',
        'isSelected': false,
        // 'name': 'New Pup',
        'name': pup.name
      });

      // await _pupsCollection.add({
      //   // 'age': 1,
      //   'age': pup.age,
      //   // 'breed': 'Unknown',
      //   'breed': pup.breed,
      //   'id': docId.id,
      //   'image_url':
      //       'https://firebasestorage.googleapis.com/v0/b/my-pups-36a9a.appspot.com/o/my_pups%2Fdog_incognito.jpg.webp?alt=media&token=9b92f4eb-ee0b-4bd2-b3a7-c8e35608caee',
      //   'isSelected': false,
      //   // 'name': 'New Pup',
      //   'name': pup.name
      // });
    } catch (e) {}
  }

  Future deletePup(String id) async {
    print('this pup id will be dleted: $id');
    try {
      await _pupsCollection.doc(id).delete().then((value) => print('success'));

//  update({
//      'title': title.text,
//      'content': content.text,
//    }).whenComplete(() => Navigator.pop(context));

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
