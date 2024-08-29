import 'package:mydevice/models/assets_model.dart';
import 'package:mydevice/models/login_user_model.dart';
import 'package:mydevice/models/organization_model.dart';
import 'package:mydevice/models/ticket_model.dart'; // Import your Ticket model
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'webrtc.db');
    return await openDatabase(
      path,
      version: 4, // Increment version number if adding new tables
      onCreate: (db, version) async {
        print("Creating tables...");
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)',
        );
        await db.execute('''
          CREATE TABLE organizations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            admin_first_name TEXT NOT NULL,
            admin_last_name TEXT NOT NULL,
            type TEXT,
            category TEXT,
            size TEXT,
            gst_no TEXT,
            msme_no TEXT,
            contact_no TEXT,
            address TEXT
          )
        ''');

        await db.execute(
          "CREATE TABLE assets("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "assetType TEXT, "
              "modelName TEXT, "
              "modelNo TEXT, "
              "serialNo TEXT"
              ")",
        );

        // Create table for tickets
        await db.execute(
          "CREATE TABLE tickets("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "assetType TEXT, "
              "assetSubType TEXT, "
              "issueType TEXT, "
              "description TEXT, "
              "status TEXT, "
              "date TEXT"
              ")",
        );

        print("Tables created.");
      },
    );
  }

  // User operations
  Future<void> insertUser(LoginUser loginUser) async {
    final db = await this.db;

    await db.insert(
      'users',
      loginUser.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getUserByEmail(String email) async {
    final db = await this.db;

    return await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<List<Map<String, dynamic>>> getUserByEmailAndPassword(String email, String password) async {
    final db = await this.db;

    return await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
  }

  // Organization operations
  Future<void> insertOrganization(OrganizationModel organization) async {
    final dbClient = await db;
    await dbClient.insert(
      'organizations',
      organization.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<OrganizationModel?> getOrganizationById(int id) async {
    final dbClient = await db;
    final result = await dbClient.query(
      'organizations',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return OrganizationModel.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateOrganization(OrganizationModel organization, Future<void> Function(OrganizationModel organization) updateOrganization) async {
    final db = await this.db;

    Map<String, dynamic> values = {
      'name': organization.name ?? '',
      'admin_first_name': organization.adminFirstName ?? '',
      'admin_last_name': organization.adminLastName ?? '',
      'type': organization.type ?? '',
      'category': organization.category ?? '',
      'size': organization.size ?? '',
      'gst_no': organization.gstNo ?? '',
      'msme_no': organization.msmeNo ?? '',
      'contact_no': organization.contactNo ?? '',
      'address': organization.address ?? '',
    };

    print('Updating organization with values: $values');

    return await db.update(
      'organizations',
      values,
      where: 'id = ?',
      whereArgs: [organization.id],
    );
  }

  Future<void> deleteOrganization(int id) async {
    final dbClient = await db;
    await dbClient.delete(
      'organizations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Asset operations
  Future<void> insertAsset(Asset asset) async {
    final dbClient = await db;
    await dbClient.insert(
      'assets',
      asset.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Asset>> getAssets() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('assets');
    return List.generate(maps.length, (i) {
      return Asset.fromMap(maps[i]);
    });
  }

  Future<void> updateAsset(Asset asset) async {
    final dbClient = await db;
    await dbClient.update(
      'assets',
      asset.toMap(),
      where: "id = ?",
      whereArgs: [asset.id],
    );
  }

  Future<void> deleteAsset(int id) async {
    final dbClient = await db;
    await dbClient.delete(
      'assets',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Ticket operations
  Future<void> insertTicket(Ticket ticket) async {
    final dbClient = await db;
    await dbClient.insert(
      'tickets',
      ticket.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Ticket>> getTickets() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('tickets');
    return List.generate(maps.length, (i) {
      return Ticket.fromMap(maps[i]);
    });
  }

  Future<Ticket?> getTicketById(int id) async {
    final dbClient = await db;
    final result = await dbClient.query(
      'tickets',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Ticket.fromMap(result.first);
    }
    return null;
  }

  Future<void> updateTicket(Ticket ticket) async {
    final dbClient = await db;
    await dbClient.update(
      'tickets',
      ticket.toMap(),
      where: "id = ?",
      whereArgs: [ticket.id],
    );
  }

  Future<void> deleteTicket(int id) async {
    final dbClient = await db;
    await dbClient.delete(
      'tickets',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
