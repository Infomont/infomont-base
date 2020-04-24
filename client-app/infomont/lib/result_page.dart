import 'package:app/hike_option.dart';
import 'package:flutter/material.dart';

import 'hike_option_provider.dart';
import 'hike_option_widget.dart';

class ResultPage extends StatefulWidget {
  ResultPage({this.hikeOptionProvider, Key key, this.title}) : super(key: key);

  final String title;
  final HikeOptionProvider hikeOptionProvider;

  @override
  _ResultPageState createState() => _ResultPageState(this.hikeOptionProvider);
}

class _ResultPageState extends State<ResultPage> {
  _ResultPageState(this.hikeOptionProvider) : super();

  final _formKey = GlobalKey<FormState>(debugLabel: 'MainForm');
  final HikeOptionProvider hikeOptionProvider;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Results for: '
                'Breaza - Chalet Urlea'), // TODO: replace with content from web API
            ButtonBar(children: <Widget>[
              FlatButton(
                child: Text('Show map'),
                onPressed: () {},
              ),
            ]),
            FutureBuilder<List<HikeOption>>(
                future: hikeOptionProvider.fetchHikeOptions('Complex turistic Sambata', 'Fereastra Mare a Sambetei'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? Expanded(
                          child: HikeOptionsList(hikeOptions: snapshot.data))
                      : Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}

class HikeOptionsList extends StatelessWidget {
  final List<HikeOption> hikeOptions;

  HikeOptionsList({Key key, this.hikeOptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hikeOptions.length,
      itemBuilder: (context, index) {
        return HikeOptionWidget(hikeOptions[index]);
      },
    );
  }
}
