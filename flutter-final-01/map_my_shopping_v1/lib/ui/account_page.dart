import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MapMyShopping"),
      ),
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Card2(),
          ],
        ),
      ),
    );
  }
}

const testy = "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH";
const Question1 = "How do I search for an item? > uhhhhhh patrick?";
const Question2 = "How do I use the map? > uhhhhhhhh parick?";
const Question3 = "How do I add to a list? > uhhhhhhhh arick?";
const Question4 = "How do I get to my favorite lists? > uhhhhhhhh rick?";
const Question5 = "Where is the checkout? > uhhhhhhhh rik?";

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildImg(double height, String text) {
      return SizedBox(
          height: height,
          child: Container(
            decoration: const BoxDecoration(
              /*
              color: color,
              text: text,
              */
              image: DecorationImage(
                image: AssetImage('assets/s.JPG'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.rectangle,
            ),
          ));
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Welcome Tips",
                  ),
                ],
              ),
            ),
          ]);
    }

    //The color of the dropdown menu
    buildCollapsed2() {
      return buildImg(150, testy);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Tips to Get Started",
                  ),
                  Text(
                    "Please Follow Frequently Asked Questions Below",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      );
    }

    buildExpanded3() {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              Question1,
              softWrap: true,
            ),
            Text(
              Question2,
              softWrap: true,
            ),
            Text(
              Question3,
              softWrap: true,
            ),
            Text(
              Question4,
              softWrap: true,
            ),
            Text(
              Question5,
              softWrap: true,
            ),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
              Expandable(
                collapsed: buildCollapsed2(),
                expanded: buildExpanded2(),
              ),
              Expandable(
                collapsed: buildCollapsed3(),
                expanded: buildExpanded3(),
              ),
              const Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      var controller =
                          ExpandableController.of(context, required: true)!;
                      return TextButton(
                        child: Text(
                          controller.expanded ? "Collapse " : "Expand",
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.deepPurple),
                        ),
                        onPressed: () {
                          controller.toggle();
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
