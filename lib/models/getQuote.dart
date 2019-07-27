// class GetQuote {
//   final String property;
//   final String quote;

//   GetQuote({this.property, this.quote});

//   factory GetQuote.fromJson(Map<String, dynamic> json) {
//     return GetQuote(
//       property: json['property'],
//       quote: json['quote'],
//     );
//   }
// }
class GetQuote {
  final String property;
  final String quote;

  GetQuote(this.property, this.quote);

  factory GetQuote.fromJson(Map<String, dynamic> json) {
    return GetQuote(
     json['property'],
     json['quote'],
    );
  }
}