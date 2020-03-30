import 'package:honguyen/models/models.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class FamilyTreeWidget extends StatefulWidget {
  Person person;
  Key key;
  bool isFirstChild = false;
  bool isLastChild = false;
  bool isRootNode = false;
  Color lineColor;

  FamilyTreeWidget({
    this.key,
    this.person,
    this.isLastChild = false,
    this.isFirstChild = false,
    this.isRootNode = false,
    this.lineColor = Colors.black,
  }) : super(key: key);

  @override
  _FamilyTreeWidgetState createState() => _FamilyTreeWidgetState();
}

class _FamilyTreeWidgetState extends State<FamilyTreeWidget> {
  bool get shouldAlignBorder => widget.isFirstChild || widget.isLastChild;

  @override
  void initState() {
    super.initState();
  }

  getWidth(Person person) {
    var total = person.children.isEmpty ? 100.0 : 16.0;
    for (var child in person.children) {
      total += getWidth(child);
    }
    return total;
  }

  crossAxisAlignmentForBorder() {
    if (shouldAlignBorder) {
      return widget.isLastChild
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end;
    }
    return CrossAxisAlignment.center;
  }

  @override
  Widget build(BuildContext context) {
    var width = getWidth(widget.person);
    var childLineColor = Colors.teal;

    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: crossAxisAlignmentForBorder(),
        children: <Widget>[
          if (!widget.isRootNode)
            Container(
              color: widget.lineColor,
              width: shouldAlignBorder ? (width / 2) : width,
              height: 2,
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (!widget.isRootNode)
                Text(
                  "|",
                  style: TextStyle(color: widget.lineColor),
                ),
              GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.only(top: 30, left: 8, right: 8),
                      child: Container(
                        constraints: BoxConstraints(minWidth: 100),
                        padding: const EdgeInsets.only(top: 15, bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.teal,
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              " " + widget.person.name + " ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.teal[900],
                          width: 1,
                        ),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.person_pin,
                        size: 40,
                        color: Colors.teal,
                      ),
                    )
                  ],
                ),
                onTap: () {},
              ),
              if (widget.person.children.isNotEmpty)
                Text(
                  "|",
                  style: TextStyle(color: childLineColor),
                ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (var i = 0; i < widget.person.children.length; i++)
                      FamilyTreeWidget(
                        person: widget.person.children[i],
                        isFirstChild: i == 0,
                        isLastChild:
                            i != 0 && i == (widget.person.children.length - 1),
                        lineColor: childLineColor,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
