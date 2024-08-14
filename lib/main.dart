import 'package:flutter/material.dart';
import 'package:flutter_wa_poc/shared_preferences.dart';
import 'dart:js' as js;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WA Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter - watsonx Assistant Integration'),
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
  bool userLoggedIn = false;
  bool isLoading = false;
  String _firstName = '', _email = '';

  void _openWaScreen() {
    // open new screen
  }

  @override
  initState() {
    if (userLoggedIn) {
      js.context.callMethod("loadWaInstance", [userLoggedIn, '']);
    }
  }

  void _logout() {
    setState(() {
      userLoggedIn = false;
      _firstName = '';
      _email = '';
    });
    js.context.callMethod("loadWaInstance", [false]);
    saveUserDetails("", "");
    saveLoginState(false);
  }

  void _login() async {
    setState(() {
      isLoading = true;
    });

    saveUserDetails('Test User', 'test@example.com');
    saveLoginState(true);
    setState(() {
      userLoggedIn = true;
      _firstName = 'Test User';
      _email = 'test@example.com';
    });
    js.context.callMethod("loadWaInstance", [userLoggedIn, 'Test User']);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // Open another screen
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isLoading ? const CircularProgressIndicator() : const SizedBox(),
            userLoggedIn
                ? ElevatedButton(
                    onPressed: () => _logout(), child: const Text('Logout'))
                : ElevatedButton(
                    onPressed: () => _login(), child: const Text('Login')),
            const SizedBox(width: 10),
            userLoggedIn
                ? Text('Welcome, $_firstName ($_email)')
                : const Text(
                    'Login to access watsonx Assistant',
                  ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _openWaScreen,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.ac_unit_sharp),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
