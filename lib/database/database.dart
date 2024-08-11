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
                        CREATE TABLE t_bbs_groups(
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
                            group_id INTEGER NOT NULL,
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
