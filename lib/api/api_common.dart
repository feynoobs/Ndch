import 'package:http/http.dart' as http;

class ApiCommon
{
    final String _endPoint;

    ApiCommon(this._endPoint);

    Future<String?> request(final Map<String, String> headers) async
    {
        final uri = Uri.parse(_endPoint);
        final response = await http.get(uri, headers: headers);
        String? r;
        if (response.statusCode == 200) {
            r = response.body;
        }

        return r;
    }
}
