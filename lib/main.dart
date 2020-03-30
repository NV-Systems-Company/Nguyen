import 'package:flutter/material.dart';
import 'package:honguyen/classdefine.dart';
import 'router.dart';
import 'package:http/http.dart' as http;
import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';
import 'package:honguyen/FamilyTreeView.dart';
import 'package:honguyen/models/models.dart';
import 'package:flutter/rendering.dart';

const maintitle = "HoNguyen.vn";
const domain = "api.nguyenvan.vn";
const protocol = "http://";
const apikey = "u19TDx0G0dxr4B5x29gub2Nz9TJrk7no";
const apisecret = "o6QJc9q0752jVwbdK8VSR073seQs9z55";
const API = "http://api.nguyenvan.vn/api.php?apikey=" + apikey + "&apisecret=" + apisecret;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Họ Nguyễn',
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
        primarySwatch: Colors.red,
        primaryColor: const Color(0xFFff0000),
        accentColor: const Color(0xFFff0000),
        canvasColor: const Color(0xFFff0000),
      ),
      home: MyHomePage(title: 'Cổng Thông Tin Họ Nguyễn'),
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

class _MyHomePageState extends State<MyHomePage> {
  Person rootPerson;
  int _selectedIndex = 0;
  String title;
  final int _pageCount = 5;
  @override
  void initState() {
      super.initState();
      // prepare root member of heirarchy
      rootPerson = dummyFamily();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var apptitle = '';
    switch (_selectedIndex) {
      case 0:
        apptitle = maintitle;
        break;
      case 1:
        apptitle = maintitle + ' - Tin Nhắn';
        break;
      case 2:
        apptitle = maintitle + ' - Thông Báo';
        break;
      case 3:
        apptitle = maintitle + ' - Gia Phả';
        break;
      case 4:
        apptitle = maintitle + ' - Tài Khoản';
        break;
    }

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
        title: Center(
          child: Text(
            apptitle,
            style: TextStyle(color: const Color(0xFFeaea0a)),
          ),
        ),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: null,
            itemBuilder: (BuildContext context) {
              return choices.skip(2).map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
        leading: new Image.asset(
          'assets/logo/logo.png',
          fit: BoxFit.fill,
          width: 50,
          height: 50,
        ),
      ),
      body: _body(),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFFff0000),
          primaryColor: Colors.yellow,
        ),
        child: _bottmnav(),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _bottmnav() {
    return new BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Trang chủ'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          title: Text('Tin nhắn'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text('Thông Báo'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timeline),
          title: Text('Gia Phả'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('Tài khoản'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFFeaea0a),
      onTap: _onItemTapped,
    );
  }

  Widget _body() {
    return Stack(
      children: List<Widget>.generate(_pageCount, (int index) {
        return IgnorePointer(
          ignoring: index != _selectedIndex,
          child: Opacity(
            opacity: _selectedIndex == index ? 1.0 : 0.0,
            child: Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return new MaterialPageRoute(
                  builder: (_) => _page(index),
                  settings: settings,
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _page(int index) {
    switch (index) {
      case 0:
        return moduleHome();
      case 1:
        return moduleChat();
      case 2:
        return moduleNoti();
      case 3:
        return moduleGenearlogy();
      case 4:
        return moduleUsers();
    }

    throw "Invalid index $index";
  }

  Widget moduleHome() {
    var assetImage = new AssetImage("assets/logo/logo.png");
    var image = new Image(image: assetImage, height: 100.0, width: 50.0);
    var assetImageNew = new AssetImage("assets/images/icon_news.png");
    var imageNew = new Image(image: assetImageNew, height: 10.0, width: 10.0);
    var assetImageAbout = new AssetImage("assets/images/icon_about.png");
    var imageAbout = new Image(image: assetImageAbout, height: 80.0, width: 80.0);
    var assetImageGenealogy = new AssetImage("assets/images/icon_genealogy.png");
    var imageGenealogy = new Image(image: assetImageGenealogy, height: 80.0, width: 80.0);
    var assetImageFood = new AssetImage("assets/images/icon_food.png");
    var imageFood = new Image(image: assetImageFood, height: 80.0, width: 80.0);
    var assetImageBussiness = new AssetImage("assets/images/icon_bussiness.png");
    var imageBussiness = new Image(image: assetImageBussiness, height: 80.0, width: 80.0);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(0),
        height: 1000.0,
        width: 1000.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: GridView.count(
          crossAxisCount: 5,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              height: image.height,
              width: image.width,
              child: FlatButton(
                onPressed: _infoClick,
                child: new ConstrainedBox(
                  constraints: new BoxConstraints.expand(),
                  child: imageAbout,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              height: image.height,
              width: image.width,
              child: new FlatButton(
                onPressed: _newClick,
                child: new ConstrainedBox(
                  constraints: new BoxConstraints.expand(),
                  child: imageNew,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              height: image.height,
              width: image.width,
              child: new FlatButton(
                onPressed: _newClick,
                child: new ConstrainedBox(
                  constraints: new BoxConstraints.expand(),
                  child: imageGenealogy,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              height: image.height,
              width: image.width,
              child: new FlatButton(
                onPressed: _newClick,
                child: new ConstrainedBox(
                  constraints: new BoxConstraints.expand(),
                  child: imageFood,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              height: image.height,
              width: image.width,
              child: new FlatButton(
                onPressed: _newClick,
                child: new ConstrainedBox(
                  constraints: new BoxConstraints.expand(),
                  child: imageBussiness,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              height: image.height,
              width: image.width,
              child: new FlatButton(
                onPressed: _newClick,
                child: new ConstrainedBox(
                  constraints: new BoxConstraints.expand(),
                  child: image,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget moduleChat() {
    var assetImage = new AssetImage("assets/logo/logo.png");
    var image = new Image(image: assetImage, height: 100.0, width: 330.0);
    return new Container(
        height: image.height, width: image.width, child: image);
  }

  Widget moduleNoti() {
    var assetImage = new AssetImage("assets/logo/logo.png");
    var image = new Image(image: assetImage, height: 100.0, width: 330.0);
    return new Container(
      height: image.height,
      width: image.width,
      child: image,
    );
  }

  Widget moduleGenearlogy() {
    var assetImage = new AssetImage("assets/logo/logo.png");
    var image = new Image(image: assetImage, height: 100.0, width: 330.0);
    return new Container(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: BidirectionalScrollViewPlugin(
          child: Container(
            // Use of Family Tree widget. Have to pass the Root family member
            child: FamilyTreeWidget(
              person: rootPerson,
              isRootNode: true,
            ),
          ),
        ),
      ),
    );
  }

  Widget moduleUsers() {
    var assetImage = new AssetImage("assets/logo/logo.png");
    var image = new Image(image: assetImage, height: 100.0, width: 330.0);
    return new Container(
      height: image.height,
      width: image.width,
      child: image,
    );
  }

  void _newClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewRoute()),
    );
  }
  void _infoClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoRoute()),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Car', icon: Icons.directions_car),
  const Choice(title: 'Bicycle', icon: Icons.directions_bike),
  const Choice(title: 'Boat', icon: Icons.directions_boat),
  const Choice(title: 'Bus', icon: Icons.directions_bus),
  const Choice(title: 'Train', icon: Icons.directions_railway),
  const Choice(title: 'Walk', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.red,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
