import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB
{
    static Future<Database>? _instance;

    static Future<Database> getInstance() async
    {
        _instance ??= openDatabase(
            join(await getDatabasesPath(), 'ndch.db'),
            version: 1,
            onCreate: ((final Database db, final int version) {

                db.execute(
                    '''
                        CREATE TABLE t_bbs(
                            id INTEGER PRIMARY KEY AUTOINCREMENT,
                            group_id INTEGER NOT NULL,
                            name TEXT NOT NULL,
                            url TEXT NOT NULL,
                            created_at TEXT NOT NULL,
                            uodated_at TEXT NOT NULL
                        )
                    '''
                );
                db.execute(
                    '''
                        CREATE TABLE t_boards(
                            id INTEGER PRIMARY KEY AUTOINCREMENT,
                            parent_id INTEGER NOT NULL,
                            created_at TEXT NOT NULL,
                            uodated_at TEXT NOT NULL
                        )
                    '''
                );
                db.execute(
                    '''
                        CREATE TABLE t_threads(
                            id INTEGER PRIMARY KEY AUTOINCREMENT,
                            parent_id INTEGER NOT NULL,
                            title TEXT NOT NULL,
                            created_at TEXT NOT NULL,
                            uodated_at TEXT NOT NULL
                        )
                    '''
                );
            })
        );

        return _instance!;
    }
}
