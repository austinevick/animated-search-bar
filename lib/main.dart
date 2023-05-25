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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool isSearching = false;
  late final AnimationController controller;
  late final Animation<Offset> visible;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    visible = Tween(begin: Offset(0.0, -5.0), end: Offset(0.0, 0.0))
        .animate(controller);

    controller.addListener(() {
      if (visible.isDismissed) {
        setState(() => isSearching = false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            isSearching
                ? SlideTransition(
                    position: visible,
                    child: SizedBox(
                      height: 60,
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          controller.reverse();
                        },
                        onVerticalDragUpdate: (details) {
                          controller.reverse();
                        },
                        child: Material(
                          elevation: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    controller.reverse();
                                  },
                                  icon: Icon(Icons.clear)),
                              const Expanded(
                                child: TextField(
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      hintText: 'Search',
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Home',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              setState(() => isSearching = true);
                              controller.forward();
                            },
                            icon: Icon(Icons.search)),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
