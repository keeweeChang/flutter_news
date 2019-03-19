import 'dart:convert';

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
        deleted = parserJson['deleted'] ?? false,
        type = parserJson['type'],
        by = parserJson['by'],
        time = parserJson['time'],
        text = parserJson['text'] ?? '',
        dead = parserJson['dead'] ?? false,
        parent = parserJson['parent'],
        kids = parserJson['kids'] ?? [],
        url = parserJson['url'],
        score = parserJson['score'],
        title = parserJson['title'],
        descendants = parserJson['descendants'];

  ItemModel.fromDb(Map<String, dynamic> parserJson)
      : id = parserJson['id'],
        deleted = parserJson['deleted'] == 1,
        type = parserJson['type'],
        by = parserJson['by'],
        time = parserJson['time'],
        text = parserJson['text'],
        dead = parserJson['dead'] == 1,
        parent = parserJson['parent'],
        kids = jsonDecode(parserJson['kids']),
        url = parserJson['url'],
        score = parserJson['score'],
        title = parserJson['title'],
        descendants = parserJson['descendants'];

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      "id": id,
      "deleted": deleted ? 1 : 0,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "dead": dead ? 1 : 0,
      "parent": parent,
      "kids": jsonEncode(kids),
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
    };
  }
}
