import 'package:cuet_event_management/view/auth/login_screen.dart';
import 'package:cuet_event_management/view/auth/register_screen.dart';
import 'package:flutter/material.dart';

class TabControlScreen extends StatefulWidget {
  const TabControlScreen({Key? key}) : super(key: key);

  @override
  TabControlScreenState createState() => TabControlScreenState();
}

class TabControlScreenState extends State<TabControlScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                "Hello, There",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 5),
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              Container(
                height: 44,
                width: 295,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: TabBar(
                  controller: tabviewController,
                  labelPadding: EdgeInsets.zero,
                  labelColor: Colors.black,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  indicatorPadding: const EdgeInsets.all(4.0),
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(width: 5.0, color: Colors.red),
                    insets: EdgeInsets.symmetric(horizontal: 32.0),
                  ),
                  tabs: const [
                    Tab(
                      child: Text("Login"),
                    ),
                    Tab(
                      child: Text("Register"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 690,
                child: TabBarView(
                  controller: tabviewController,
                  children: const [
                    LoginScreen(),
                    RegisterScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
