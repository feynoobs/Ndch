import 'api_common.dart';
import '../dao/board_object.dart';
import '../dao/bbs_object.dart';

class GetBoardList extends ApiCommon
{
    GetBoardList() : super('https://www2.5ch.net/5ch.html');

    Future<List<BBSObject>> doRequest() async
    {
        List<BBSObject> r = [];

        final Map<String, String> headerParams = {
            'Accept-Encoding': 'gzip, compress',
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X x.y; rv:42.0) Gecko/20100101 Firefox/42.0'
        };
        String? ret = await request(headerParams);
        if (ret != null) {
            final RegExp exp1 = RegExp(r'<br><br><B>(.+?)</B><br>\n((?:<A HREF=".+?">.+?</A>(?:<br>)?\n)+)');
            final RegExp exp2 = RegExp(r'(?:<A HREF="(.+?)">(.+?)</A>(?:<br>)?)+');
            final Iterable<RegExpMatch> matches1 = exp1.allMatches(ret);
            for (final m1 in matches1) {
                List<BoardObject> group = [];
                final Iterable<RegExpMatch> matches2 = exp2.allMatches(m1[2]!);
                for (final m2 in matches2) {
                    group.add(BoardObject(m2[1]!, m2[2]!));

                }
                r.add(BBSObject(m1[1]!, group));
            }
        }

        return r;
    }
}
