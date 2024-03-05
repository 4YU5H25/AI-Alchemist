import 'dart:io';

import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/login.dart';
import 'package:chat/pages/quiz.dart';
import 'package:flutter/material.dart';
import 'package:chat/pages/firebase_auth_service.dart';
import 'journal.dart';

class Home extends StatefulWidget {
  Home({required this.mail, this.link = '', this.name = ''});
  String mail = '';
  String link = '';
  String name = '';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var W = MediaQuery.of(context).size.width;
    var H = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            AuthServices.signoutUser(context);
          },
          icon: const Icon(
            Icons.logout_sharp,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 9, 171),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.jpg'), fit: BoxFit.fitWidth),
        ),
        height: H,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width / 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.transparent,
                ),
                color: const Color.fromARGB(
                    96, 96, 125, 139), // Suitable color for the first column
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (widget.link != '')
                    ClipOval(child: Image.network(widget.link))
                  else
                    const Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.white,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${widget.mail}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (widget.name != '')
                    Text(
                      widget.name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () async {
                        await AuthServices.signoutUser(context);
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () async {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                        await AuthServices.signoutUser(context);
                      },
                      child: const Text("Login with Different Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            Container(
              height: H,
              width: 4.5 * W / 6,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: Container(
                            height: H / 4,
                            width: W / 5,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(85, 0, 170, 255),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Go to Chatbot",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "Engage with your AI Helper",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ChatPage()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: Container(
                            height: H / 4,
                            width: W / 5,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(85, 0, 170, 255),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black)),
                            child: const Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Little Hearts, Bright Minds",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "Discover Your Child's Mental Well-being ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MentalHealthQuizPage()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: Container(
                            height: H / 4,
                            width: W / 5,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(85, 0, 170, 255),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Journal Forge",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "Craft Your Thoughts into Written Gems",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => JournalPage ()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
