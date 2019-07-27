class ViewDetails {
  final String fullname;
  final String email , image_url;
  final List tags;

  ViewDetails({this.fullname, this.email, this.tags , this.image_url});

  factory ViewDetails.fromJson(Map<String, dynamic> json) {
    return ViewDetails(
      email: json['email'],
      fullname: json['fullname'],
      tags: json['tags'],
      image_url: json['image_url']
    );
  }
}