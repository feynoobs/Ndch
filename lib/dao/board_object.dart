import 'thread_object.dart';

class BoardObject
{
    int id;
    String url;
    String name;
    List<ThreadObject> threads;

    BoardObject(this.url, this.name, {this.id = 0, this.threads = const []});
}
