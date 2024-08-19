import 'package:sqflite/sqflite.dart';
import '../api/get_board_list.dart';
import '../dao/board_object.dart';
import 'database.dart';

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
                    t_boards.url AS board_url
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
                BoardObject bo;
                final String group = record['bbs_name'] as String;
                final String board = record['board_name'] as String;
                final String url = record['board_url'] as String;

                BoardObject? object = boardObjectSearch(group, ret);
                object ??= BoardObject(group, {});

                object.group = group;
                object.boards[board] = url;
                ret.add(object);
            }
        }
        // データベースにBBSの情報がない場合
        else {
            ret = await GetBoardList().doRequest();
            await _instance.transaction((final Transaction txn) async {
                int bbsSort = 0;
                for (final BoardObject object in ret) {
                    Map<String, Object?> bbsData = {};
                    ++bbsSort;
                    bbsData['name'] = object.group;
                    bbsData['sort'] = bbsSort;
                    bbsData['created_at'] = now();
                    bbsData['uodated_at'] = now();
                    int id = await txn.insert('t_bbs', bbsData);
                    int boardSort = 0;
                    object.boards.forEach((final String key, final String value) async {
                        Map<String, Object?> boardData = {};
                        ++boardSort;
                        boardData['bbs_id'] = id;
                        boardData['name'] = key;
                        boardData['url'] = value;
                        boardData['sort'] = boardSort;
                        boardData['created_at'] = now();
                        boardData['uodated_at'] = now();
                        await txn.insert('t_boards', boardData);
                    });
                }
            });
        }

        return ret;
    }
}
