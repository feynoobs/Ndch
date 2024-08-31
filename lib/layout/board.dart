import 'package:flutter/material.dart';
import '../dao/board_object.dart';
import '../database/database.dart';
import '../database/get_bbs.dart';
import 'common.dart';

class BBS extends StatefulWidget
{
    const BBS({super.key});

    @override
    State<BBS> createState() => _BBSState();
}

class _BBSState extends State<BBS>
{
    final List<Widget> _columns = [];

    Future<void> _initialize() async
    {
        List<BoardObject> bbses = await GetBBS(await DB.getInstance()).get();
        setState(() {
            for (final BoardObject bbs in bbses) {
                List<GestureDetector> item = <GestureDetector>[];
                for (final key in bbs.boards.keys) {
                    item.add(
                        GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                                margin: const EdgeInsets.only(left: 20, bottom: 4),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        key,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 18,
                                        )
                                    )
                                )
                            )
                        )
                    );
                }
                _columns.add(
                    ExpansionTile(
                        title: Text(bbs.group),
                        key: ValueKey(bbs.group),
                        children: item
                    )
                );
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
