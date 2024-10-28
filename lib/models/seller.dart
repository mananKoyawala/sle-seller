class Seller {
  final String id;
  final String first_name;
  final String last_name;
  final String email;
  final String password;
  final String phone;
  final String image_url;
  final String address;
  final String pan_card;
  final String dob;
  final String company_name;
  final String description;
  final bool is_verified;
  final bool is_email_verified;
  final String gst_number;
  final String created_at;
  final String updated_at;

  Seller(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.password,
      required this.phone,
      required this.image_url,
      required this.address,
      required this.pan_card,
      required this.dob,
      required this.company_name,
      required this.description,
      required this.is_verified,
      required this.is_email_verified,
      required this.gst_number,
      required this.created_at,
      required this.updated_at});

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
        id: json["s_id"],
        first_name: json["s_first_name"],
        last_name: json["s_last_name"],
        email: json["s_email"],
        password: json["s_password"],
        phone: json["s_phone"],
        image_url: json["s_image_url"],
        address: json["s_address"],
        pan_card: json["s_pan_card"],
        dob: json["s_dob"],
        company_name: json["s_company_name"],
        description: json["s_discription"],
        is_verified: json["is_verified"],
        is_email_verified: json["is_email_verified"],
        gst_number: json["s_gst_number"],
        created_at: json["created_at"],
        updated_at: json["updated_at"]);
  }
}
