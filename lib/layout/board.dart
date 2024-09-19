import 'package:flutter/material.dart';
import '../dao/thread_object.dart';
import '../database/database.dart';
import '../database/get_board.dart';
import 'common.dart';

class Board extends StatefulWidget
{
    final String url;
    const Board({required this.url, super.key});

    @override
    State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board>
{
    final List<Widget> _columns = [];

    Future<void> _initialize() async
    {
        final List<ThreadObject> boards = await GetBoard(await DB.getInstance(), widget.url).get();
        setState(() {
            for (final ThreadObject board in boards) {
                List<GestureDetector> item = <GestureDetector>[];
            }
        });
    }

    @override
    void initState()
    {
        super.initState();
        _initialize();
    }

    @override
    Widget build(BuildContext context)
    {
        final ScrollController scrollController = ScrollController();

        return Scaffold(
            appBar: const EmptyAppBar(),
            body: NotificationListener<ScrollNotification> (
                child: Scrollbar(
                    child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: _columns.length,
                        itemBuilder: (final BuildContext _, final int index) {
                            return _columns[index];
                        },
                    )
                )
            ),
        );
    }
}
