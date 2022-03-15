// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Pup _$$_PupFromJson(Map<String, dynamic> json) => _$_Pup(
      name: json['name'] as String,
      sex: json['sex'] as String,
      breed: json['breed'] as String,
      age: json['age'] as int,
      owner: json['owner'] as String,
      imageUrl: json['imageUrl'] as String,
      hasClinic: json['hasClinic'] as bool? ?? false,
      petClinic: json['petClinic'] as String,
      vetName: json['vetName'] as String,
      vetNotes: json['vetNotes'] as String,
      lastVisit: json['lastVisit'],
      nextVisit: json['nextVisit'],
      id: json['id'] as String,
    );

Map<String, dynamic> _$$_PupToJson(_$_Pup instance) => <String, dynamic>{
      'name': instance.name,
      'sex': instance.sex,
      'breed': instance.breed,
      'age': instance.age,
      'owner': instance.owner,
      'imageUrl': instance.imageUrl,
      'hasClinic': instance.hasClinic,
      'petClinic': instance.petClinic,
      'vetName': instance.vetName,
      'vetNotes': instance.vetNotes,
      'lastVisit': instance.lastVisit,
      'nextVisit': instance.nextVisit,
      'id': instance.id,
    };
