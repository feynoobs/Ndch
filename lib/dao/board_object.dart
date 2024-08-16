class BoardObject
{
    String group;
    List<Map<String, String>> boards;

    BoardObject(this.group, this.boards);
}

BoardObject? boardObjectSearch(final String group, final List<BoardObject> objects)
{
    BoardObject? ret;
    for (final BoardObject object in objects) {
        if (object.group == group) {
            ret = object;
        }
    }

    return ret;
}
