import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:charset_converter/charset_converter.dart';

class ApiCommon
{
    final String _endPoint;
    final Logger _logger = Logger();

    ApiCommon(this._endPoint);

    Future<String?> request(final Map<String, String> headers) async
    {
        final uri = Uri.parse(_endPoint);
        String r = await http
            .get(uri, headers: headers)
            .then((final http.Response response) {
                if (response.statusCode == 200) {
                    return CharsetConverter.decode('cp932', response.bodyBytes);
                }
                else {
                    throw Exception('Failed to load data');
                }
            })
            .catchError((err) {
                _logger.e(err);
                return err.toString();
            });

        return r;
    }
}
