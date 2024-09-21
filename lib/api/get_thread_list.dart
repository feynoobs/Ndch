import 'package:google_maps_in_flutter/dao/board_object.dart';

import 'api_common.dart';
import '../dao/thread_object.dart';

class GetThreadList extends ApiCommon
{
    GetThreadList(super.url);

    Future<BoardObject> doRequest() async
    {
        BoardObject? r;

        final Map<String, String> headerParams = {
            'Accept-Encoding': 'gzip, compress',
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X x.y; rv:42.0) Gecko/20100101 Firefox/42.0'
        };
        String? ret = await request(headerParams);
        if (ret != null) {
            final RegExp exp = RegExp(r'(\d+)?\.dat<>(.+?)\(\d+\)\n');
            final Iterable<RegExpMatch> matches = exp.allMatches(ret);
            final List<ThreadObject> t = [];
            for (final RegExpMatch m in matches) {
                t.add(ThreadObject(m[1] as int, m[3] as int, m[2]!));
            }
            r?.threads = t;
        }

        return r!;
    }
}
