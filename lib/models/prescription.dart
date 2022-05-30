// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Prescription {
  String mail;
  String name;
  String addr;
  String Imgurl;
  Prescription({
    required this.mail,
    required this.name,
    required this.addr,
    required this.Imgurl,
  });

  Prescription copyWith({
    String? mail,
    String? name,
    String? addr,
    String? Imgurl,
  }) {
    return Prescription(
      mail: mail ?? this.mail,
      name: name ?? this.name,
      addr: addr ?? this.addr,
      Imgurl: Imgurl ?? this.Imgurl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mail': mail,
      'name': name,
      'addr': addr,
      'Imgurl': Imgurl,
    };
  }

  factory Prescription.fromMap(Map<String, dynamic> map) {
    return Prescription(
      mail: map['mail'] as String,
      name: map['name'] as String,
      addr: map['addr'] as String,
      Imgurl: map['Imgurl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Prescription.fromJson(String source) =>
      Prescription.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Prescription(mail: $mail, name: $name, addr: $addr, Imgurl: $Imgurl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Prescription &&
        other.mail == mail &&
        other.name == name &&
        other.addr == addr &&
        other.Imgurl == Imgurl;
  }

  @override
  int get hashCode {
    return mail.hashCode ^ name.hashCode ^ addr.hashCode ^ Imgurl.hashCode;
  }
}
