class AgenceModel {
  String? uid;
  String? nom;
  String? domaine;
  String? size;
  String? email;
  String? numero;
  String? adresse;
  String? description;
  String? img;
  String? date;
  late List<dynamic> dept;

  AgenceModel({
    this.uid,
    this.email,
    this.nom,
    this.domaine,
    this.date,
    this.size,
    this.numero,
    this.adresse,
    this.description,
    this.img,
    dept,
  });

//receiving data from server
  factory AgenceModel.fromMap(map) {
    return AgenceModel(
      uid: map['uid'],
      email: map['email'],
      nom: map['nom'],
      domaine: map['domaine'],
      size: map['size'],
      adresse: map['adresse'],
      description: map['description'],
      dept: map['dept'],
      img: map['img'],
      date: map['date'],
      numero: map['numero'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nom': nom,
      'domaine': domaine,
      'size': size,
      'adresse': adresse,
      'description': description,
      'dept': dept,
      'img': img,
      'date': date,
      'numero': numero,
    };
  }
}
