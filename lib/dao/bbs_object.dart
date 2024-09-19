import 'board_object.dart';

class BBSObject
{
    int id;
    String bbs;
    List<BoardObject> boards;

    BBSObject(this.id, this.bbs, {this.boards = const []});
}
