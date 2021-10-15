import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class database{


  void main() async {
    final database = openDatabase(

      join(await getDatabasesPath(), 'contactinfos_database.db'),

      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },

      version: 1,
    );

    Future<void> insertDog(Contact contact) async {

      final Database db = await database;


      await db.insert(
        'contacts',
        contact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<List<Contact>> contacts() async {

      final Database db = await database;


      final List<Map<String, dynamic>> maps = await db.query('dogs');


      return List.generate(maps.length, (i) {
        return Contact(
          id: maps[i]['id'],
          name: maps[i]['name'],
          age: maps[i]['age'],
        );
      });
    }

    Future<void> updateDog(Contact contact) async {

      final db = await database;


      await db.update(
        'contacts',
        contact.toMap(),

        where: "id = ?",

        whereArgs: [contact.id],
      );
    }

    Future<void> deleteDog(int id) async {

      final db = await database;


      await db.delete(
        'contacts',

        where: "id = ?",

        whereArgs: [id],
      );
    }

    var fido = Contact(
      id: 0,
      name: 'Fido',
      age: 35,
    );


    await insertDog(fido);


    print(await contacts());


    fido = Contact(
      id: fido.id,
      name: fido.name,
      age: fido.age + 7,
    );
    await updateDog(fido);


    print(await contacts());


    await deleteDog(fido.id);


    print(await contacts());
  }

}

class Contact{
  final int id;
  final String name;
  final int age;

  Contact({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }


  @override
  String toString() {
    return 'Contact{id: $id, name: $name, age: $age}';
  }
}