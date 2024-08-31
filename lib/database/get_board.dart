import 'package:sqflite/sqflite.dart';
import '../api/get_board_list.dart';
import '../dao/thread_object.dart';
import 'database.dart';

class GetBoard
{
    final Database _instance;

    GetBoard(this._instance);

    Future<List<ThreadObject>> get() async
    {
        final List<Map<String, Object?>> bbses = await _instance.rawQuery(
            '''
                SELECT
                    id,
                    name AS bbs_name
                FROM
                    t_bbses
                ORDER BY
                    sort
            '''
        );
        List<ThreadObject> ret = [];
        // データベースにBBSの情報がある場合
        if (bbses.isNotEmpty) {
            for (final Map<String, Object?> bbs in bbses) {
                final List<Map<String, Object?>> boards = await _instance.rawQuery(
                    '''
                        SELECT
                            name AS board_name,
                            url AS board_url
                        FROM
                            t_boards
                        WHERE
                            bbs_id = ?
                        ORDER BY
                            sort
                    '''
                ,  [bbs['id']]);
                Map<String, String> group = {};
                for (final Map<String, Object?> board in boards) {
                    final String b = board['board_name'] as String;
                    final String u = board['board_url'] as String;
                     group[b] = u;
                }
                ret.add(ThreadObject(bbs['bbs_name'] as String, group));
            }
        }
        // データベースにBBSの情報がない場合
        else {
            ret = await GetBoardList().doRequest();
            await _instance.transaction((final Transaction txn) async {
                int bbsSort = 0;
                for (final ThreadObject object in ret) {
                    Map<String, Object?> bbsData = {};
                    ++bbsSort;
                    bbsData['name'] = object.group;
                    bbsData['sort'] = bbsSort;
                    bbsData['created_at'] = now();
                    bbsData['uodated_at'] = now();
                    int id = await txn.insert('t_bbses', bbsData);
                    int boardSort = 0;
                    object.boards.forEach((final String key, final String value) async {
                        final Map<String, Object?> boardData = {};
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
