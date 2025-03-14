class VcardModel {
  VcardModel({
    this.id,
    this.alias,
    this.name,
    this.occupation,
    this.description,
    this.avatar,
    this.background,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.location,
    this.dob,
    this.company,
    this.position,
    this.templateID,
    this.website,
    this.facebook,
    this.zalo,
    this.tiktok,
    this.instagram,
    this.youtube,
    this.linkedin,
    this.whatsapp,
  });

  int? id;
  String? alias;
  String? name;
  String? occupation;
  String? description;
  String? avatar;
  String? background;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? location;
  String? dob;
  String? company;
  String? position;
  int? templateID;
  String? website;
  String? facebook;
  String? zalo;
  String? tiktok;
  String? instagram;
  String? youtube;
  String? linkedin;
  String? whatsapp;

  factory VcardModel.fromJson(Map<String, dynamic> json) {
    return VcardModel(
      id: json['id'] as int?,
      alias: json['url_alias'] as String?,
      name: json['name'] as String?,
      occupation: json['occupation'] as String?,
      description: json['description'] as String?,
      avatar: json['profile_url'] as String?,
      background: json['cover_url'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      dob: json['dob'] as String?,
      company: json['company'] as String?,
      position: json['job_title'] as String?,
      templateID: json['template_id'] as int?,
      website: json['website'] as String?,
      facebook: json['facebook'] as String?,
      zalo: json['zalo'] as String?,
      tiktok: json['tiktok'] as String?,
      instagram: json['instagram'] as String?,
      youtube: json['youtube'] as String?,
      linkedin: json['linkedin'] as String?,
      whatsapp: json['whatsapp'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url_alias': alias,
      'name': name,
      'occupation': occupation,
      'description': description,
      'profile_url': avatar,
      'cover_url': background,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'location': location,
      'dob': dob,
      'company': company,
      'job_title': position,
      'template_id': templateID,
      'website': website,
      'facebook': facebook,
      'zalo': zalo,
      'tiktok': tiktok,
      'instagram': instagram,
      'youtube': youtube,
      'linkedin': linkedin,
      'whatsapp': whatsapp,
    };
  }
}
