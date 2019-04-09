class ViewDetails {
  final String fullname;
  final String email;
  final List tags;

  ViewDetails({this.fullname, this.email, this.tags});

  factory ViewDetails.fromJson(Map<String, dynamic> json) {
    return ViewDetails(
      email: json['email'],
      fullname: json['fullname'],
      tags: json['tags'],
    );
  }
}