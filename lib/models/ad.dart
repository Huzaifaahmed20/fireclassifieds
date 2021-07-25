class Ad {
  final String uid;
  final String title;
  final String descp;
  final String price;
  final String phoneNum;

  Ad({this.uid, this.title, this.descp, this.price, this.phoneNum});

  Ad.fromJson(Map<String, Object> json)
      : this(
          uid: json['uid'] as String,
          title: json['title'] as String,
          descp: json['descp'] as String,
          price: json['price'] as String,
          phoneNum: json['phoneNum'] as String,
        );

  Map<String, Object> toJson() {
    return {
      'uid': uid,
      'title': title,
      'descp': descp,
      'price': price,
      'phoneNum': phoneNum,
    };
  }
}
