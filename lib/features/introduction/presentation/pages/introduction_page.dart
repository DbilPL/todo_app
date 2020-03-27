import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class IntroducitonPage extends StatefulWidget {
  @override
  _IntroducitonPageState createState() => _IntroducitonPageState();
}

class _IntroducitonPageState extends State<IntroducitonPage> {
  static const flareFilesData = [
    {'name': 'Intro1', 'text': 'Simple to use.'},
    {'name': 'Intro2', 'text': 'Cloud saving'},
    {'name': 'Intro3', 'text': 'Your data is safe'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: flareFilesData.length,
      initialIndex: 0,
      child: Builder(
        builder: (BuildContext context) => SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TabPageSelector(
                selectedColor: Theme.of(context).primaryColor,
              ),
              Expanded(
                child: TabBarView(
                  children: flareFilesData.map(
                    (val) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              val['text'],
                              style: TextStyle(
                                fontSize: 35,
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              child: FlareActor(
                                'assets/animations/${val['name']}.flr',
                                animation: 'animate',
                              ),
                            ),
                            val['name'] == 'Intro3'
                                ? RaisedButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/auth');
                                    },
                                    child: Text(
                                      'Start work',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor,
                                      ),
                                    ),
                                    color: Theme.of(context).primaryColor,
                                  )
                                : Text(''),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
