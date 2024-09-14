import 'package:flutter/material.dart';
import 'common.dart';

class Board extends StatefulWidget
{
    final int id;
    const Board({required this.id, super.key});

    @override
    State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board>
{
    final List<Widget> _columns = [];

    @override
    void initState()
    {
        super.initState();
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
