import 'package:sqflite/sqflite.dart';
import '../api/get_board_list.dart';
import '../dao/board_object.dart';

class GetBBS
{
    final Database _instance;

    GetBBS(this._instance);

    Future<List<BoardObject>> get() async
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
        List<BoardObject> ret = [];
        // データベースにBBSの情報がある場合
        if (datas.isNotEmpty) {
            for (final Map<String, Object?> record in datas) {
                final String bbs = record['bbs_name'] as String;
                final String board = record['board_name'] as String;
                final String url = record['board_url'] as String;

                BoardObject? object = boardObjectSearch(record['bbs_name'] as String, ret);
                if (object == null) {
                    BoardObject object = BoardObject(record['bbs_name'] as String, []);
                    object.group = bbs;
                    ret.add(object);
                }
                object!.boards.add({board: url});
            }
        }
        // データベースにBBSの情報がない場合
        else {
            ret = await GetBoardList().doRequest();
            for (final BoardObject object in ret) {

            }
        }
    }

}
