import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB
{
    static Database? _instance;

    static Future<Database> getInstance() async
    {
        _instance ??= await openDatabase(
            join(await getDatabasesPath(), 'ndch.db'),
            version: 1,
            onCreate: ((final Database db, final int version) {

                db.execute(
                    '''
                        CREATE TABLE t_bbs(
                            id INTEGER PRIMARY KEY AUTOINCREMENT,
                            name TEXT NOT NULL,
                            sort INTEGER NOT NULL,
                            created_at TEXT NOT NULL,
                            uodated_at TEXT NOT NULL
                        )
                    '''
                );
                db.execute(
                    '''
                        CREATE TABLE t_boards(
                            id INTEGER PRIMARY KEY AUTOINCREMENT,
                            bbs_id INTEGER NOT NULL,
                            url TEXT NOT NULL,
                            sort INTEGER NOT NULL,
                            created_at TEXT NOT NULL,
                            uodated_at TEXT NOT NULL
                        )
                    '''
                );
                db.execute(
                    '''
                        CREATE TABLE t_threads(
                            id INTEGER PRIMARY KEY AUTOINCREMENT,
                            board_id INTEGER NOT NULL,
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

String now()
{
    return DateTime.now().toIso8601String();
}
