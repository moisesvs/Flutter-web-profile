import "PostFeed.dart";

class Profile {
  final String name;
  final String surname;
  final List<PostFeed> posts;

  Profile({this.name, this.surname, this.posts});

  factory Profile.fromJson(Map<String, dynamic> json) {
    var list = json['posts'] as List;
    List<PostFeed> itemsList = list.map((i) => PostFeed.fromJson(i)).toList();

    return Profile(
      name: json['name'],
      surname: json['surname'],
      posts: itemsList
    );
  }
}