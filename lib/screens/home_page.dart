import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_app/controller/json_controller.dart';
import 'package:planet_app/screens/detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    JsonController jc = Get.put(JsonController());
    jc.getData();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Planets",style: TextStyle(color: Colors.white),),
      ),
      body: GetBuilder<JsonController>(builder: (context) {
        if (jc.jsonData.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: jc.jsonData.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 1),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return DetailScreen(planet: jc.jsonData[index]);
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var turnsTween =
                                Tween(begin: 0.0, end: 1.0).animate(animation);

                            return RotationTransition(
                              turns: turnsTween,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: RotationTransition(
                      turns: _controller,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          '${jc.jsonData[index].image}',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${jc.jsonData[index].name}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
