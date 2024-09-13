import 'package:flutter/material.dart';
import '../dao/bbs_object.dart';
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
