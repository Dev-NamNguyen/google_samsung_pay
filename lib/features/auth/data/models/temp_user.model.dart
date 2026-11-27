class TempUserModel {
  final String? uid;
  final String? name;
  final String? phone;
  final String? address;

  TempUserModel({
    this.uid,
    this.name,
    this.phone,
    this.address,
  });

  factory TempUserModel.fromJson(Map<String, dynamic> json) {
    return TempUserModel(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'TempUserModel(uid: $uid, name: $name, phone: $phone, address: $address)';
  }
}
