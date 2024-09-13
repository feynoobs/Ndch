import 'package:sqflite/sqflite.dart';
import '../api/get_thread_list.dart';
import '../dao/thread_object.dart';
import 'database.dart';

class GetBoard
{
    final Database _instance;
    final String url;

    GetBoard(this._instance, this.url);

    double _powerCalc(int dat, int res)
    {
        final double now = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;
        return res / (now - dat);
    }

    Future<List<ThreadObject>> get(final int id) async
    {
        final List<Map<String, Object?>> boards = await _instance.rawQuery(
            '''
                SELECT
                    id,
                    name AS bbs_name
                FROM
                    t_boards
                WHERE
                    id = ?
                ORDER BY
                    sort
            '''
            , [id]
        );


        List<ThreadObject> ret = [];
        // データベースにBBSの情報がある場合
        if (boards.isNotEmpty) {
            for (final Map<String, Object?> board in boards) {
                final List<Map<String, Object?>> threads = await _instance.rawQuery(
                    '''
                        SELECT
                            name AS thread_name,
                            res,
                            dat
                        FROM
                            t_threads
                        WHERE
                            bbs_id = ?
                        ORDER BY
                            sort
                    '''
                ,  [board['id']]);
                if (threads.isNotEmpty) {
                    for (final Map<String, Object?> thread in threads) {
                        ret.add(ThreadObject(thread['dat'] as int, thread['res'] as int, thread['thread_name'] as String));
                    }
                }
                else {
                    ret = await GetThreadList(url).doRequest();
                    await _instance.transaction((final Transaction txn) async {
                        for (final ThreadObject object in ret) {
                            Map<String, Object?> threadData = {};
                            threadData['name'] = object.name;
                            threadData['board_id'] = id;
                            threadData['dat'] = object.dat;
                            threadData['res'] = object.res;
                            threadData['created_at'] = now();
                            threadData['uodated_at'] = now();

                            await txn.insert('t_threads', threadData);
                        }
                    });
                }
            }
        }
        // データベースにBBSの情報がない場合
        else {
            ret = await GetThreadList(url).doRequest();
            await _instance.transaction((final Transaction txn) async {
                for (final ThreadObject object in ret) {
                    Map<String, Object?> threadData = {};
                    threadData['name'] = object.name;
                    threadData['board_id'] = id;
                    threadData['dat'] = object.dat;
                    threadData['res'] = object.res;
                    threadData['created_at'] = now();
                    threadData['uodated_at'] = now();

                    await txn.insert('t_threads', threadData);
                }
            });
        }

        return ret;
    }
}
