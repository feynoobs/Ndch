import 'thread_object.dart';

class BoardObject
{
    int id;
    String url;
    String name;

    BoardObject(this.url, this.name, {this.id = 0});
}
