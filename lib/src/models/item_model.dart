class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> parserJson)
      : id = parserJson['id'],
        deleted = parserJson['deleted'],
        type = parserJson['type'],
        by = parserJson['by'],
        time = parserJson['time'],
        text = parserJson['text'],
        dead = parserJson['dead'],
        parent = parserJson['parent'],
        kids = parserJson['kids'],
        url = parserJson['url'],
        score = parserJson['score'],
        title = parserJson['title'],
        descendants = parserJson['descendants'];
}
