import 'package:flutter/material.dart';
import './utils/Place.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Restaurapp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Place> _places = <Place>[];


  @override
  void initState() {
    super.initState();
    listenForPlaces();
  }

  listenForPlaces() async {
    var stream = await getPlaces(33.9850, -118.4695);
    stream.listen((place) => setState( ()=> _places.add(place)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new ListView(
          children: _places.map((place) => new PlaceWidget(place)).toList(),
        )
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class PlaceWidget extends StatelessWidget{
  final Place _place;

  PlaceWidget(this._place);

  Color getColor(double rating){
    return Color.lerp(Colors.red, Colors.green, rating/5);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Dismissible(
        key: new Key(_place.name),
        onDismissed: (direction) {
          direction == DismissDirection.endToStart ? Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text('NO LIKEE'))) : print('LLLIKE');
        },
        background: new Container(
          color: Colors.green,
        ),
        secondaryBackground: new Container(
          color: Colors.red,
        ),
        child: new ListTile(
          leading: new CircleAvatar(
            child: new Text(_place.rating.toString()),
            backgroundColor: getColor(_place.rating),
          ),
          title: new Text(_place.name),
          subtitle: new Text(_place.address),
        ));
  }
}
