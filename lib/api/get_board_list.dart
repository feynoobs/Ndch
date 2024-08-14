import 'package:http/http.dart';

import 'api_common.dart';

class GetBoardList extends ApiCommon
{
    GetBoardList() : super('https://www2.5ch.net/5ch.html');
    Future<String?> doRequest() async
    {
        final Map<String, String> headerParams = {
            'Accept-Encoding': 'gzip, compress',
            'User-Agent:': 'Mozilla/5.0 (Macintosh; Intel Mac OS X x.y; rv:42.0) Gecko/20100101 Firefox/42.0'
        };
        String? r = await request(headerParams);

    }
}
