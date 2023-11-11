import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;

class mailforget extends StatefulWidget {
  mailforget({required this.email});
  final String email;
  @override
  State<mailforget> createState() => _mailforgetState();
}

class _mailforgetState extends State<mailforget> {
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forget Password'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "Mail",
                  hintText: "Enter the Forget Password",
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => email = value),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    registerfun();
                  },
                  child: const Text('forget Password')),
            )
          ],
        ),
      ),
    );
  }

  void registerfun() async {
    http.Response res = await Authorepo.registerapi(email: email);
    if (res != null) {
      var response = jsonDecode(res.body);
      if (response["message"] == "EmailID is Right") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response["message"]}'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${response["message"]}'),
          ),
        );
      }
    }
  }
}

class registerurl {
  static String baseurl = "https://vstechno.co.in/news/api/user.php";
}

class Authorepo {
  static Future registerapi({
    required email,
  }) async {
    return await get(
      Uri.parse(
          "https://hentai2w.com/video/shiiba-san-no-ura-no-kao-with-imouto-lip-episode-1-5345.html "),
    );
  }
}
