import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaterialApp title',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SasukeFlutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<Widget> labels = [Text("标签01"), Text("标签02"), Text("标签03")];

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int _counter = 0;
  TabController _tabCtrl;
  PageController _pageCtrl;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }



  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3,vsync: this);
    _pageCtrl = PageController(initialPage: 0,keepPage: true);
  }

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
        // Here we take the value from the My HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        bottom: TabBar(
          labelPadding: EdgeInsets.only(left: 30.0,right: 30.0,bottom: 10.0,top: 10.0),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: labels,
          indicatorColor: Colors.orange,
          isScrollable: true,
          controller: _tabCtrl,
        ),
      ),
      body: PageView(
        onPageChanged: (index){
          _tabCtrl.animateTo(index);
        },
        controller: _pageCtrl,
        children: <Widget>[
          createPageViews(1),
          createPageViews(2),
          createPageViews(3),
        ],
      ),
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
//        child: Column(
//          // Column is also layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

createPageViews(int childrenCount){
  return ListView.builder(
    itemBuilder: (BuildContext context, int index) {
      return sasukeMainWidget(index);
    },
    itemCount: childrenCount,
  );
}

//单个Card
sasukeMainWidget(int index) {
  return Builder(builder: (BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Card(
          color: Colors.blue,
          child: FlatButton(
              onPressed: () {
                debugPrint("Sasuke - onPressed0");
                showToast(context, "你点击了第" + index.toString() + "个按钮");
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    sasukeText("这是Text_" + index.toString()),
                    sasukeText("又是Text_" + index.toString()),
                  ],
                ),
              )),
        ));
  });
}

sasukeText(String text) {
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.link,
          color: Colors.white,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}

showToast(BuildContext context, String msg) {
  debugPrint("Sasuke - onPressed2");
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    action: SnackBarAction(label: "OK", onPressed: () {}),
  ));
}
