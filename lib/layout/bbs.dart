import 'package:flutter/material.dart';
import '../dao/bbs_object.dart';
import '../database/database.dart';
import '../database/get_bbs.dart';
import 'board.dart';
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
        final List<BBSObject> bbses = await GetBBS(await DB.getInstance()).get(false);
        setState(() {
            for (final BBSObject bbs in bbses) {
                List<GestureDetector> item = <GestureDetector>[];
                for (final board in bbs.boards) {
                    item.add(
                        GestureDetector(
                            onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Board(url: board.url)));
                            },
                            child: Container(
                                margin: const EdgeInsets.only(left: 20, bottom: 8),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        board.name,
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
                        title: Text(
                            bbs.bbs,
                            style: const TextStyle(
                                fontSize: 20,
                            )
                        ),
                        key: ValueKey(bbs.id),
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
