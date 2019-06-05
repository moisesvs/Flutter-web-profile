class PostFeed {
  final int id;
  final String title;
  final String description;

  PostFeed({this.id, this.title, this.description});

  factory PostFeed.fromJson(Map<String, dynamic> jsonfeed) {
    return PostFeed(
      id: jsonfeed['id'],
      title: jsonfeed['title'],
      description: jsonfeed['description']
    );
  }
}