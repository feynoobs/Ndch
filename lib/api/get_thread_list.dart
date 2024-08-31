import 'api_common.dart';
import '../dao/board_object.dart';

class GetThreadList extends ApiCommon
{
    GetThreadList(super.url);

    Future<List<BoardObject>> doRequest() async
    {
        List<BoardObject> r = [];

        final Map<String, String> headerParams = {
            'Accept-Encoding': 'gzip, compress',
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X x.y; rv:42.0) Gecko/20100101 Firefox/42.0'
        };
        String? ret = await request(headerParams);
        if (ret != null) {
            final RegExp exp = RegExp(r'(\d+)?\.dat<>(.+?)\(\d+\)');
            final Iterable<RegExpMatch> matches = exp.allMatches(ret);
            for (final RegExpMatch m in matches) {

            }



            final RegExp exp2 = RegExp(r'(?:<A HREF="(.+?)">(.+?)</A>(?:<br>)?)+');
            for (final m1 in matches1) {
                Map<String, String> group = {};
                final Iterable<RegExpMatch> matches2 = exp2.allMatches(m1[2]!);
                for (final m2 in matches2) {
                    group[m2[2]!] = m2[1]!;
                }
                r.add(BoardObject(m1[1]!, group));
            }
        }

        return r;
    }
}
