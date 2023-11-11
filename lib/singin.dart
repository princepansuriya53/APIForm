import 'main.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;

class singin extends StatefulWidget {
  @override
  State<singin> createState() => _singinState();
}

class _singinState extends State<singin> {
  final formkey = GlobalKey<FormState>();
  String fname = '';
  String lname = '';
  String mail = '';
  String mno = '';
  String pwd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login form Api'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) => fname = value,
                  decoration: const InputDecoration(
                    labelText: "F Name",
                    hintText: "Enter the fisrt name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) => lname = value,
                  decoration: const InputDecoration(
                    labelText: "L Name",
                    hintText: "Enter the Last name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) => mail = value,
                  decoration: const InputDecoration(
                    labelText: "Mail",
                    hintText: "Enter the Mail ID",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) => mno = value,
                  decoration: const InputDecoration(
                    labelText: "Contact",
                    hintText: "Enter the Mobile-number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                    onChanged: (value) => pwd = value,
                    decoration: const InputDecoration(
                        labelText: "Pwd",
                        hintText: "Enter the Password",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))))),
              ),
              ElevatedButton(
                  onPressed: () {
                    registerfun();
                  },
                  child: const Text('Create account'))
            ],
          ),
        ),
      ),
    );
  }

  void registerfun() async {
    http.Response res = await Authorepo.registerapi(
      fname: fname,
      lname: lname,
      mail: mail,
      mno: mno,
      pwd: pwd,
    );
    print(
      "${registerurl.baseurl}?action=signup&fname=" +
          fname +
          "&lname=" +
          lname +
          "&email=" +
          mail +
          "&mno=" +
          mno +
          "&pwd=" +
          pwd,
    );
    if (res != null) {
      var response = jsonDecode(res.body);
      if (response["message"] == "Successfully Register") {
        ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(
                content: Text('${response["message"]}'),
              ),
            )
            .closed
            .then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => login(),
                ),
              ),
            );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response["message"]}'),
        ));
      }
    }
  }
}

class registerurl {
  static String baseurl = "https://vstechno.co.in/news/api/user.php";
}

class Authorepo {
  static Future registerapi({
    required fname,
    required lname,
    required mail,
    required mno,
    required pwd,
  }) async {
    return await get(
      Uri.parse(
        "${registerurl.baseurl}?action=signup&fname=" +
            fname +
            "&lname=" +
            lname +
            "&email=" +
            mail +
            "&mno=" +
            mno +
            "&pwd=" +
            pwd,
      ),
    );
  }
}
