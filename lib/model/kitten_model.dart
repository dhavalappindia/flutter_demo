/*--------------------Model Class---------------------------------------------*/
class Kitten {
  Kitten({this.userId, this.id, this.title, this.body,this.imageUrl});

  final int userId;
  final int id;
  final String title;
  final String body;
    final String imageUrl;

  factory Kitten.fromJson(Map<String, dynamic> json){
    return Kitten(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }


//  final String name;
//  final String discription;
//  final int age;
//  final String imageUrl;
}