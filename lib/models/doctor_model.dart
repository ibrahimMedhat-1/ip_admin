class DoctorModel {
  String? id;
  String? name;
  String? phoneNo;
  Map<String, dynamic>? address;
  String? speciality;
  String? bio;
  String? image;
  String? lastMessage;
  String? creationDate;

  DoctorModel(this.id, this.name, this.phoneNo, this.address, this.speciality, this.bio, this.image,
      this.creationDate);
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phoneNo': phoneNo,
        'address': address,
        'speciality': speciality,
        'bio': bio,
        'image': image,
        'creationDate': creationDate,
      };
  DoctorModel.fromJson(Map<String, dynamic>? json, {this.lastMessage}) {
    id = json!['id'];
    name = json['name'];
    phoneNo = json['phoneNo'];
    address = json['address'] as Map<String, dynamic>;
    speciality = json['speciality'];
    bio = json['bio'];
    image = json['image'];
    creationDate = json['creationDate'];
  }
}
