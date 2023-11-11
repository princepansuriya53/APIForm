import 'main.dart';
import 'package:flutter/material.dart';s

class welcome extends StatefulWidget {
  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello Welcome User',
              textScaleFactor: 2.5,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    storage.write('login', null);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  });
                },
                icon: const Icon(Icons.logout_outlined),
                label: const Text('Logut'))
          ],
        ),
      ),
    );
  }
}
