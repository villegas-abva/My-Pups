import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Pup extends Equatable {
  final String name;
  final String breed;
  final int age;
  final bool isSelected;

  const Pup(
      {required this.name,
      required this.breed,
      required this.age,
      required this.isSelected});

  Pup copyWith({
    String? name,
    String? breed,
    int? age,
    bool? isSelected,
  }) {
    return Pup(
      name: name ?? this.name,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'breed': breed});
    result.addAll({'age': age});
    result.addAll({'isSelected': isSelected});

    return result;
  }

  factory Pup.fromMap(Map<String, dynamic> map) {
    return Pup(
      name: map['name'] ?? '',
      breed: map['breed'] ?? '',
      age: map['age']?.toInt() ?? 0,
      isSelected: map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pup.fromJson(String source) => Pup.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Pups(name: $name, breed: $breed, age: $age, isSelected: $isSelected)';
  }

  static Pup pupFromSnapshot(DocumentSnapshot snapshot) {
    Pup pup = Pup(
      name: snapshot['name'],
      breed: snapshot['breed'],
      age: snapshot['age'],
      isSelected: snapshot['isSelected'],
    );
    return pup;
  }

  @override
  List<Object> get props => [
        name,
        breed,
        isSelected,
        age,
      ];
}
