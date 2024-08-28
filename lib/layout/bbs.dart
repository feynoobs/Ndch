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
    List<BoardObject>? bbses;
    List<Widget> aaa = [];

    Future<void> _initialize() async
    {
        bbses = await GetBBS(await DB.getInstance()).get();
        setState(() {
            int axa = 0;
            for (final BoardObject bbs in bbses!) {
                ++axa;
                aaa!.add(Container
                (
                    key: ValueKey(axa),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey,
                                width: 0.2
                            ),
                        ),
                    ),
                    child: Text(bbs.group)
                ));
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
                child: Scrollbar(child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: bbses!.length,
                    itemBuilder: (final BuildContext _, final int index) {
                        return aaa![index];
                    },
                ),
            )
        ));
    }
}
