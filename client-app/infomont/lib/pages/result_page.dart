import 'package:app/db/hike_option_provider.dart';
import 'package:app/entities/hike_option.dart';
import 'package:app/entities/hike_option_search_parameters.dart';
import 'package:app/widgets/hike_option_widget.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String title;
  final HikeOptionProvider hikeOptionProvider;
  final HikeOptionSearchParameters searchParameters;

  ResultPage(
      {this.hikeOptionProvider,
      Key key,
      this.title,
      @required this.searchParameters})
      : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  _ResultPageState() : super();

  final _formKey = GlobalKey<FormState>(debugLabel: 'MainForm');

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: new BoxDecoration(color: Color(0xFF445B18)),
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(fontWeight: FontWeight.normal),
                            children: <TextSpan>[
                          TextSpan(
                              text: 'Results for: ',
                              style: TextStyle(color: Color(0xFEFDD124))),
                          TextSpan(
                              text: widget.searchParameters.departurePoint,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: ' - ',
                              style: TextStyle(color: Color(0xFEFDD124))),
                          TextSpan(
                              text: widget.searchParameters.destinationPoint,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]))),
                ButtonBar(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: RaisedButton(
                      child: Text('Show map (todo)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Color(0xFF445B18))),
                      onPressed: () {},
                    ),
                  )
                ]),
                FutureBuilder<List<HikeOption>>(
                    future: widget.hikeOptionProvider.fetchHikeOptions(
                        widget.searchParameters.departurePointId,
                        widget.searchParameters.destinationPointId),
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        print(snapshot.error);

                      return snapshot.hasData
                          ? Expanded(
                              child:
                                  HikeOptionsList(hikeOptions: snapshot.data))
                          : Center(child: CircularProgressIndicator());
                    }),
              ],
            ),
          )),
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
