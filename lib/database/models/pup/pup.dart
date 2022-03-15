import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pup.freezed.dart';
part 'pup.g.dart';

@Freezed()
class Pup with _$Pup {
  const factory Pup({
    required String name,
    required String sex,
    required String breed,
    required int age,
    required String owner,
    required String imageUrl,
    @Default(false) bool hasClinic,
    required String petClinic,
    required String vetName,
    required String vetNotes,
    required dynamic lastVisit,
    required dynamic nextVisit,
    required String id,
  }) = _Pup;

  factory Pup.fromJson(Map<String, dynamic> json) => _$PupFromJson(json);

  // factory Pup.fromSnapshot(Map<String, dynamic> json) =>
  //     _$PupFromSnapshot(json);

  static Pup pupFromSnapshot(DocumentSnapshot snapshot) {
    Pup pup = Pup(
      name: snapshot['name'] ?? '',
      sex: snapshot['sex'] ?? '',
      breed: snapshot['breed'] ?? '',
      age: snapshot['age'] ?? 0,
      owner: snapshot['owner'] ?? '',
      imageUrl: snapshot['imageUrl'] ?? '',
      hasClinic: snapshot['hasClinic'] ?? false,
      petClinic: snapshot['petClinic'] ?? '',
      vetName: snapshot['vetName'] ?? '',
      vetNotes: snapshot['vetNotes'] ?? '',
      lastVisit: snapshot['lastVisit'] ?? '',
      nextVisit: snapshot['nextVisit'] ?? '',
      id: snapshot['id'] ?? '',
    );
    return pup;
  }
}
