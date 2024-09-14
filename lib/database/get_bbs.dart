import 'package:sqflite/sqflite.dart';
import '../api/get_board_list.dart';
import '../dao/bbs_object.dart';
import '../dao/board_object.dart';
import 'database.dart';

class GetBBS
{
    final Database _instance;

    GetBBS(this._instance);

    Future<List<BBSObject>> get() async
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
        List<BBSObject> ret = [];
        // データベースにBBSの情報がある場合
        if (bbses.isNotEmpty) {
            for (final Map<String, Object?> bbs in bbses) {
                final List<Map<String, Object?>> boards = await _instance.rawQuery(
                    '''
                        SELECT
                            id AS board_id,
                            name AS board_name,
                            url AS board_url
                        FROM
                            t_boards
                        WHERE
                            bbs_id = ?
                        ORDER BY
                            sort
                    '''
                , [bbs['id']]);

                final List<BoardObject> boardObjects = [];
                for (final Map<String, Object?> board in boards) {
                    boardObjects.add(BoardObject(board['board_id'] as int, board['board_url'] as String, board['board_name'] as String));
                }
                ret.add(BBSObject(bbs['bbs_name'] as String, boardObjects));
            }
        }
        // データベースにBBSの情報がない場合
        else {
            ret = await GetBoardList().doRequest();
            await _instance.transaction((final Transaction txn) async {
                int bbsSort = 0;
                for (final BBSObject object in ret) {
                    Map<String, Object?> bbsData = {};
                    ++bbsSort;
                    bbsData['name'] = object.bbs;
                    bbsData['sort'] = bbsSort;
                    bbsData['created_at'] = now();
                    bbsData['uodated_at'] = now();
                    int id = await txn.insert('t_bbses', bbsData);
                    int boardSort = 0;
                    for (final BoardObject board in object.boards) {
                        final Map<String, Object?> boardData = {};
                        ++boardSort;
                        boardData['bbs_id'] = id;
                        boardData['name'] = board.name;
                        boardData['url'] = board.url;
                        boardData['sort'] = boardSort;
                        boardData['created_at'] = now();
                        boardData['uodated_at'] = now();
                        await txn.insert('t_boards', boardData);
                    }
                }
            });
        }

        return ret;
    }
}
