import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:map_my_shopping_v1/ui/nav_bar.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key}) : super();

  @override
  State createState() {
    return HelpPageState();
  }
}

class HelpPageState extends State<HelpPage> {
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
          children: const <Widget>[
            Card2(),
          ],
        ),
      ),
      bottomNavigationBar: const TopLevelNavBar(navState: 0),
    );
  }
}

const text = "Welcome!";
const question1 =
    "How do I search for an item?                                              >Use the search page, to type in and find your item.";
const question2 = "How do I use the map? >TBD";
const question3 =
    "How do I add to a list?                                                   >After finding your item through the search page click the add button on the item to add it to your list.";
const question4 =
    "Where is the checkout?                                                    >This app is not affiliated with any company or store. This app is to aid in navigation and help you find your items easier.";

class Card2 extends StatelessWidget {
  const Card2({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    buildImg(double height, String text) {
      return SizedBox(
          height: height,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Icon Instruct.JPG'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.rectangle,
            ),
          ));
    }

    buildImg1(double height, String text) {
      return SizedBox(
          height: height,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Instruct.JPG'),
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

    //The color of the dropdown menu image instruct
    buildCollapsed2() {
      return buildImg(100, text);
      // return buildImg1(150);
    }

    //image s
    buildCollapsed3() {
      return buildImg1(150, text);
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
              question1,
              softWrap: true,
            ),
            Text(
              question2,
              softWrap: true,
            ),
            Text(
              question3,
              softWrap: true,
            ),
            Text(
              question4,
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
