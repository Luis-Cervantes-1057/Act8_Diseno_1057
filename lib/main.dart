import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:act8_diseno_1057/Dashboard.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController? rippleController;
  AnimationController? scaleController;

  Animation<double>? rippleAnimation;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    rippleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    scaleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: Dashboard()));
            }
          });

    rippleAnimation =
        Tween<double>(begin: 80.0, end: 90.0).animate(rippleController!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rippleController?.reverse();
            } else if (status == AnimationStatus.dismissed) {
              rippleController?.forward();
            }
          });

    scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(scaleController!);

    rippleController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: makePage(image: 'assets/images/fondo.png'),
    );
  }

  Widget makePage({required String image}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coca-Cola',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 5)],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '235',
                  style: TextStyle(
                    color: Colors.yellow[400],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Peso (ml)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '107',
                  style: TextStyle(
                    color: Colors.yellow[400],
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Energia (kcal)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Acompaña con una bebida\ntus comidas favoritas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: rippleAnimation!,
                    builder: (context, child) => Container(
                      width: rippleAnimation?.value,
                      height: rippleAnimation?.value,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(.4),
                        ),
                        child: InkWell(
                          onTap: () {
                            scaleController?.forward();
                          },
                          child: AnimatedBuilder(
                            animation: scaleAnimation!,
                            builder: (context, child) => Transform.scale(
                              scale: scaleAnimation?.value,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: scaleController?.status ==
                                            AnimationStatus.forward ||
                                        scaleController?.status ==
                                            AnimationStatus.completed
                                    ? null
                                    : Center(
                                        child: Icon(
                                          Icons.fingerprint,
                                          size: 40,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
