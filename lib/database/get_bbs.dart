import 'package:sqflite/sqflite.dart';
import '../api/get_board_list.dart';

class GetBBS
{
    final Database _instance;

    GetBBS(this._instance);

    Future<BoardObject> get() async
    {
        final List<Map<String, Object?>> datas = await _instance.rawQuery(
            '''
                SELECT
                    t_bbs.name AS bbs_name,
                    t_boards.name AS board_name,
                    t_boards.url AS board_url,
                FROM
                    t_bbs
                INNER JOIN
                    t_boards
                ON
                    t_bbs.id = t_boards.bbs_id
                ORDER BY
                    t_bbs.sort, t_boards.sort

            '''
        );
        if (datas.isNotEmpty) {
            for (final Map<String, Object?> record in datas) {
            }
        }
    }



}
