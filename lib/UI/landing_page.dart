import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopliax_todo/Config/routes/route_location.dart';
import 'package:shopliax_todo/Utils/app_colors.dart';

class LandingPage extends StatelessWidget {
  static LandingPage builder(BuildContext context, GoRouterState state) =>
      const LandingPage();
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.sizeOf(context).height;
    final _weight = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade800,
              // Deep blue
              const Color(0xFFC2DFFF), // Light mix of blue and white
              Colors.white,
              // blue,
              // white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Spacer(),
              Icon(
                Icons.layers,
                size: 200,
                color: Colors.grey.shade200,
              ),
              SizedBox(height: _height * 0.15),
              const Text(
                "Welcome to Go Task",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Text(
                "Plan your daily activities with this simple todo app!!!",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: _height * 0.15),
              Center(
                child: Container(
                  width: _weight / 1.5,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextButton(
                    child: const Text(
                      "Let's Start",
                      style: TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      context.go(RouteLocation.home);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
