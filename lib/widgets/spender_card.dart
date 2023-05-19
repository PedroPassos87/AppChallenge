import 'package:challenge_app/models/spender.dart';
import 'package:challenge_app/pages/spender_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/favorites_repository.dart';

class SpenderCard extends StatefulWidget {
  Spender spender;

  SpenderCard({Key? key, required this.spender}) : super(key: key);

  @override
  _SpenderCardState createState() => _SpenderCardState();
}

class _SpenderCardState extends State<SpenderCard> {

  static Map<String, Color> valueColor = <String, Color>{
    'up': Colors.teal,
    'down': Colors.deepPurpleAccent,
  };

  openDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SpenderDetailsPage(spender: widget.spender),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => openDetails(),
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
          child: Row(
            children: [
              Image.asset(
                widget.spender.icon,
                height: 40,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.spender.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: valueColor['down']!.withOpacity(0.1),
                  border: Border.all(
                    color: valueColor['down']!.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  '${widget.spender.spent} MB',
                  style: TextStyle(
                    fontSize: 16,
                    color: valueColor['down'],
                    letterSpacing: -1,
                  ),
                ),
              ),
              PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      title: Text('Remove'),
                      onTap: () {
                        Navigator.pop(context);
                        Provider.of<FavoritesRepository>(context, listen: false)
                            .remove(widget.spender);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
