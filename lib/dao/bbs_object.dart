import 'board_object.dart';

class BBSObject
{
    int id;
    String bbs;
    List<BoardObject> boards;

    BBSObject(this.bbs, this.boards, {this.id = 0});
}
