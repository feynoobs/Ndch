import 'package:http/http.dart' as http;

abstract class ApiCommon
{
    final String _endPoint;

    ApiCommon(this._endPoint);

    Future<String?> startMain(final Map<String, String> params)
    {
        final uri = Uri.parse(_endPoint);
    }
}
