// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PharmacyUser {
  String? mail;
  String? name;
  String? phone;
  String? addr;
  PharmacyUser({
    required this.mail,
    required this.name,
    required this.phone,
    required this.addr,
  });

  PharmacyUser copyWith({
    String? mail,
    String? name,
    String? phone,
    String? addr,
  }) {
    return PharmacyUser(
      mail: mail ?? this.mail,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      addr: addr ?? this.addr,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mail': mail,
      'name': name,
      'phone': phone,
      'addr': addr,
    };
  }

  factory PharmacyUser.fromMap(Map<String, dynamic> map) {
    return PharmacyUser(
      mail: map['mail'] != null ? map['mail'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      addr: map['addr'] != null ? map['addr'] as String : null,
    );
  }

  factory PharmacyUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return PharmacyUser(
      mail: data?['mail'] as String,
      name: data?['name'] as String,
      phone: data?['phone'] as String,
      addr: data?['addr'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (mail != null) "mail": mail,
      if (phone != null) "phone": phone,
      if (addr != null) "addr": addr,
    };
  }

  String toJson() => json.encode(toMap());

  factory PharmacyUser.fromJson(String source) =>
      PharmacyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PharmacyUser(mail: $mail, name: $name, phone: $phone, addr: $addr)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PharmacyUser &&
        other.mail == mail &&
        other.name == name &&
        other.phone == phone &&
        other.addr == addr;
  }

  @override
  int get hashCode {
    return mail.hashCode ^ name.hashCode ^ phone.hashCode ^ addr.hashCode;
  }
}
