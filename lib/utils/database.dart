import 'package:path/path.dart';
import 'package:scoaladesoft/woocommerce/shipping.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseUtils {
  var database;

  DatabaseUtils() {
    createDatabaseTables();

    Shipping shipping = Shipping(
        firstName: 'Alex',
        lastName: 'Bordei',
        country: "RO",
        city: "Bucharest",
        address1: "Strada Strazilor, nr 113");

    inserUserShippingData(shipping);
  }

  void createDatabaseTables() async {
    try {
      if (database != null) {
        database = openDatabase(
          // Set the path to the database. Note: Using the `join` function from the
          // `path` package is best practice to ensure the path is correctly
          // constructed for each platform.
          join(await getDatabasesPath(), 'woo_database.db'),
          // When the database is first created, create a table to store dogs.
          onCreate: (db, version) {
            // Run the CREATE TABLE statement on the database.
            return db.execute(
              'CREATE TABLE user(id INTEGER PRIMARY KEY, shipping_first_nam TEXT, shipping_last_name TEXT, shipping_address1 TEXT, shipping_address2 TEXT, shipping_city TEXT, shipping_state TEXT, shipping_postcode TEXT, shipping_country TEXT)',
            );
          },
          // Set the version. This executes the onCreate function and provides a
          // path to perform database upgrades and downgrades.
          version: 2,
        );
      }
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> inserUserShippingData(Shipping obj) async {
    if (database != null) {
      database = openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'woo_database.db'),
        // When the database is first created, create a table to store dogs.
        onCreate: (db, version) {
          // Run the CREATE TABLE statement on the database.
          db.insert(
            'user',
            obj.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 2,
      );
    }
  }
}
