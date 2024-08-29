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
                List<Align> item = <Align>[];
                for (final key in bbs.boards.keys) {
                    item.add(
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                key,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    shadows: <Shadow>[
                                        Shadow(
                                            color: Colors.grey,
                                            offset: Offset(5.0, 5.0),
                                            blurRadius: 3.0,
                                        )
                                    ]
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
