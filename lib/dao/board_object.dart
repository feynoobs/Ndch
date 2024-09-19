import 'thread_object.dart';

class BoardObject
{
    int id;
    String url;
    String name;
    List<ThreadObject> threads;

    BoardObject(this.id, this.url, this.name, {this.threads = const []});
}
