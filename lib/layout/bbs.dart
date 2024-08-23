import 'package:flutter/material.dart';
import '../dao/board_object.dart';
import '../database/database.dart';
import '../database/get_bbs.dart';

class BBS extends StatefulWidget
{
    const BBS({super.key});

    @override
    State<BBS> createState() => _BBSState();
}

class _BBSState extends State<BBS>
{
    List<BoardObject>? bbses;
/*
    Future<void> _initialize() async
    {
        final ins = await DB.getInstance();
        bbses = await GetBBS(ins).get();
    }

    @override
    void initState() async
    {
        super.initState();
        _initialize();
    }
*/

    @override
    Widget build(BuildContext context)
    {
        return Row(

        );
    }
}
