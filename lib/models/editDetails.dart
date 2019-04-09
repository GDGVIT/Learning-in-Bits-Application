class EditDetails {
  final String fullname;
  final String email;

  EditDetails({this.fullname, this.email});

  factory EditDetails.fromJson(Map<String, dynamic> json) {
    return EditDetails(
      email: json['email'],
      fullname: json['fullname'],
    );
  }
}