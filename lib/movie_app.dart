import 'package:flutter/material.dart';
import 'home/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: HomePage(),
    );
  }
}







/*class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 40,
      ),
      body: Stack(children: [
        Image(
          image:
          // ResizeImage(
          AssetImage('assets/images/Wallpaper_1.jpg'),
          // width: 720,
          // height: 1080),
          height: 1000,
          fit: BoxFit.fitHeight,
        ),
        Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text(
                  'Counting App',
                  style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold ),
                ),
              ]),
        ),
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have pushed the button this many times:',
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                    color: Colors.blueGrey,
                    width: 270,
                    height:5
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
                ElevatedButton(onPressed: _resetCounter, child: Text("Reset"))
              ],
            )),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
*/