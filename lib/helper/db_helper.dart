import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/FakestoreModel.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), "favorites.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorite(
            id INTEGER PRIMARY KEY,
            title TEXT,
            price REAL,
            description TEXT,
            category TEXT,
            image TEXT,
            rate REAL,
            count INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertFavorite(FakestoreModel product) async {
    final dbClient = await db;
    await dbClient.insert(
      "favorite",
      {
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'category': product.category.name,
        'image': product.image,
        'rate': product.rating.rate,
        'count': product.rating.count,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(int id) async {
    final dbClient = await db;
    await dbClient.delete("favorite", where: "id = ?", whereArgs: [id]);
  }

  Future<List<FakestoreModel>> getFavorites() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query("favorite");

    return List.generate(maps.length, (i) {
      return FakestoreModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        category: _categoryFromString(maps[i]['category']),
        image: maps[i]['image'],
        rating: Rating(rate: maps[i]['rate'], count: maps[i]['count']),
      );
    });
  }

  Category _categoryFromString(String category) {
    switch (category) {
      case "ELECTRONICS":
        return Category.ELECTRONICS;
      case "JEWELERY":
        return Category.JEWELERY;
      case "MEN_S_CLOTHING":
        return Category.MEN_S_CLOTHING;
      case "WOMEN_S_CLOTHING":
        return Category.WOMEN_S_CLOTHING;
      default:
        return Category.ELECTRONICS;
    }
  }
}
