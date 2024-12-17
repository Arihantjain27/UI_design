import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 139, 183)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'f'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPercentage = 0.0;
  bool _isAppbarvisible = true;
  int _selectedIndex = 0;

    final List<Widget> _pages = <Widget>[
    const Center(child: Text('Home Page')),
    const Center(child: Text('Search Page')),
    const Center(child: Text('Notifications Page')),
    const Center(child: Text('Messages Page')),
    const Center(child: Text('Profile Page')),
  ];


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollPercentage);
  }

  void _updateScrollPercentage() {
    if (_scrollController.hasClients) {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScrollPosition = _scrollController.offset;
      setState(() {
        _scrollPercentage = maxScrollExtent > 0
            ? (currentScrollPosition / maxScrollExtent * 100).clamp(0.0, 100.0)
            : 0.0;

        if (_scrollPercentage <= 14) {
          _isAppbarvisible = true;
        } else {
          _isAppbarvisible = false;
        }
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollPercentage);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:_isAppbarvisible != true? PreferredSize(preferredSize:  Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height * 0.05), child: Container(
        child: AnimatedSwitcher(
          duration: Duration(seconds: 5),
             transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    //   width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.25,
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.only(top:25.0,right: 14),
                      child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.notification_add,color: Colors.white,),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.file_copy,color: Colors.white,),
                                onPressed: () {},
                              )
                            ],
                          ),
                    ),
                  ))),
        ),
      )):null,
      // appBar: AppBar(
      //   forceMaterialTransparency: _isAppbarvisible,
      //   backgroundColor: Color.fromARGB(255, 0, 134, 243),
      //   title: _isAppbarvisible != true ? Text('Conectar'):Text(""),
      //   actions: [
      //   _isAppbarvisible != true ?  IconButton(icon: Icon(Icons.notification_add),onPressed: () {
      //     },):Container(),
      //      _isAppbarvisible != true ? IconButton(icon: Icon(Icons.file_copy),onPressed: () {
      //     },):Container()
      //   ],
      // ),
      body: Stack(
        children: [
          CachedNetworkImage(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            imageUrl: "https://img.freepik.com/free-photo/vivid-colored-transparent-autumn-leaf_23-2148239739.jpg",
            fit: BoxFit.cover,
          ),
          Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                   Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.notification_add,color: Colors.white,),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.file_copy,color: Colors.white),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 14.0, right: 14.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Center(
                          child: CarouselSlider(
                            options: CarouselOptions(height: 200.0,viewportFraction: 1),
                            items: [1, 2, 3, 4, 5].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                    
                                        width: MediaQuery.of(context).size.width,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration:
                                            BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            'text $i',
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        )),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 1000,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: const Column(
                       children: [
                        Expanded(child: MyListValue()),
                        Expanded(child: MyListValue()),
                        Expanded(child: MyListValue()),
                        Expanded(child: MyListValue())
                       ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // important to allow 5 items
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


class MyListValue extends StatelessWidget {
  const MyListValue({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("Heading Of Section",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),TextButton.icon(icon: Icon(Icons.arrow_back_ios),onPressed: (){},label: Text("More"),)],),
        ),
        Flexible(child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: 4,itemBuilder:(context,int){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 200,width: 250,child: Center(child: Text("$int Card")),decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(10)),),
          );
        } ))
      ],
    );
  }
}
