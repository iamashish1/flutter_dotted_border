import 'package:flutter/material.dart';
import 'package:flutter_dotted_border/flutter_dotted_border.dart'
    show
        BorderSideToExclude,
        DefaultDottedCircularBorder,
        DottedBorder,
        DottedCircularBorderByNumber,
        RectDottedBorder;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: DottedBorder(
                    borderType: DefaultDottedCircularBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ),
                Text("Example 1"),
                SizedBox(height: 20),

                Align(
                  alignment: Alignment.center,
                  child: DottedBorder(
                    borderType: DottedCircularBorderByNumber(
                      numberOfDashes: 4,
                      activeCount: 3,
                      activeColor: Colors.green,
                      inactiveColor: Colors.blueGrey,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ),
                Text("Example 2"),

                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: DottedBorder(
                    borderType: RectDottedBorder(dashWidth: 5),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                        height: 70,
                        width: 70,
                      ),
                    ),
                  ),
                ),
                Text("Example 3"),

                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: DottedBorder(
                    borderType: RectDottedBorder(
                      dashWidth: 20,
                      exclude: {BorderSideToExclude.top},
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                        height: 70,
                        width: 70,
                      ),
                    ),
                  ),
                ),
                Text("Example 4"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
