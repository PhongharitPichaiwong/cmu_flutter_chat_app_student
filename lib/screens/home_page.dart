import 'package:cmu_chat_app/screens/chat_list_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../providers/auth_provider.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String displayName;

  const HomePage({
    Key? key,
    required this.displayName,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> onBackPress() {
    Fluttertoast.showToast(msg: 'Back button pressed!');
    return Future.value(false);
  }

  Future<void> signOut() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    authProvider.googleSignOut();

    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const LoginPage();
        },
      ),
      (_) => false,
    );
  }

  void openChatList() {
    // Fluttertoast.showToast(msg: 'Chat list pressed!');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatListPage()),
    );
  }

  Widget _buildOpenChatListBtn() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        elevation: 4,
        shadowColor: const Color(0xFF162A49),
      ),
      onPressed: openChatList,
      child: const Text('Chat List'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          title: Text(
            'Hi, ${widget.displayName}',
            style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.white),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: signOut,
              icon: const Icon(Icons.logout),
              color: Colors.white,
            ),
          ],
        ),
        body: WillPopScope(
          onWillPop: onBackPress,
          child: Stack(
            children: <Widget>[
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        child: _buildOpenChatListBtn()),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
