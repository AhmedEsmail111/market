import 'package:path/path.dart' as path;
import 'package:shop_app/shared/constants/constants.dart';
import 'package:sqflite/sqflite.dart' as sql;

abstract class LocalDatabase {
  // open the database
  static Future<sql.Database> createDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'home_data.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE ${AppConstants.productsTable} (id INTEGER PRIMARY KEY, price REAL , old_price REAL, discount INTEGER, image TEXT, name TEXT, description TEXT, images TEXT, in_favorites BOOLEAN, in_cart BOOLEAN)');

        await db.execute(
            'CREATE TABLE ${AppConstants.bannersTable}(id INTEGER PRIMARY KEY, image TEXT)');

        await db.execute(
            'CREATE TABLE ${AppConstants.categoriesTable}(id INTEGER PRIMARY KEY, name TEXT, image TEXT)');
      },
      version: 1,
    );
    return db;
  }

// insert a banner
  static Future<void> insertBanner(int id, String image) async {
    final db = await createDatabase();
    db.rawInsert(
      'INSERT INTO ${AppConstants.bannersTable} (id, image) VALUES(? , ?)',
      [id, image],
    ).then((value) => print('done banners inserting'));
  }

// get all banners
  static Future<List<Map<String, dynamic>>> getBanners() async {
    final db = await createDatabase();
    return db.rawQuery('SELECT * FROM ${AppConstants.bannersTable}');
  }

  // insert a category
  static Future<void> insertCategory(
      {required int id, required String name, required String image}) async {
    final db = await createDatabase();
    db.rawInsert(
      'INSERT INTO ${AppConstants.categoriesTable} (id, name, image) VALUES(? , ? , ?)',
      [id, name, image],
    ).then((value) => print('done categories inserting'));
  }

  // get all categories
  static Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await createDatabase();
    return db.rawQuery('SELECT * FROM ${AppConstants.categoriesTable}');
  }

  // insert a product
  static Future<void> insertProduct({
    required int id,
    required num price,
    required num oldPrice,
    required int discount,
    required String name,
    required String image,
    required String images,
    required String description,
    required bool inFavorites,
    required bool inCart,
  }) async {
    final db = await createDatabase();
    db.rawInsert(
      'INSERT INTO ${AppConstants.productsTable} (id, price, old_price, discount, image, name, description, images, in_favorites, in_cart) VALUES(? , ? , ? , ? , ? , ? , ? , ? , ?,? )',
      [
        id,
        price.toDouble(),
        oldPrice.toDouble(),
        discount,
        image,
        name,
        description,
        images,
        inFavorites,
        inCart
      ],
    ).then((value) => print('done products inserting'));
  }

  // get all categories
  static Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await createDatabase();
    return db.rawQuery('SELECT * FROM ${AppConstants.productsTable}');
  }

// get the count of the number of rows in the tale
  static Future<int?> getCount(String tableName) async {
    final db = await createDatabase();

    return sql.Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

// delete all tables in the data base, it is used when the user change the language and restart the app
// , we call it then the app when restarted go fetch the data with the new language
  static Future deleteAllData() async {
    final db = await createDatabase();

    await db.delete(AppConstants.bannersTable);
    await db.delete(AppConstants.productsTable);
    await db.delete(AppConstants.categoriesTable);
  }
}
