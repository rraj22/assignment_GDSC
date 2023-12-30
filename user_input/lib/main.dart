import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Details App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.orange,
      ),
      home: UserDetailsInputPage(),
      routes: {
        '/userDetails': (context) => UserDetailsDisplayPage(),
      },
    );
  }
}

class UserDetailsInputPage extends StatefulWidget {
  @override
  _UserDetailsInputPageState createState() => _UserDetailsInputPageState();
}

class _UserDetailsInputPageState extends State<UserDetailsInputPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Function to clear text fields
  void clearFields() {
    nameController.clear();
    emailController.clear();
    rollNoController.clear();
    phoneController.clear();
  }

  void showDetails() {
    final Map<String, String> userDetails = {
      'name': nameController.text,
      'email': emailController.text,
      'rollNo': rollNoController.text,
      'phone': phoneController.text,
    };
    Navigator.pushNamed(
      context,
      '/userDetails',
      arguments: userDetails,
    ).then((value) {
      if (value != null && value is bool && value) {
        // If logged out, clear the text fields
        clearFields();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('User ${userDetails['name']} Logged out'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter User Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: rollNoController,
              decoration: InputDecoration(labelText: 'Roll No'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: showDetails,
              child: Text('Show Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetailsDisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> userDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${userDetails['name']}'),
            Text('Email: ${userDetails['email']}'),
            Text('Roll No: ${userDetails['rollNo']}'),
            Text('Phone Number: ${userDetails['phone']}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        tooltip: 'Logout',
        child: Icon(Icons.logout),
      ),
    );
  }
}
