import 'package:final_project/header.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isError = false;
  bool isErrorForPassword = false;
  String password = '';
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() => setState(() {}));
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward(); // Animasyonu başlat

    return Scaffold(
      appBar: const Header(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FadeTransition(
              opacity: _animation,
              child: getUsernameArea(),
            ),
            FadeTransition(
              opacity: _animation,
              child: getPasswordArea(),
            ),
            ScaleTransition(
              scale: _animation,
              child: loginButton(),
            ),
          ],
        ),
      ),
    );
  }

  //Login Button
  Row loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            usernameController.text == 'burak' &&
                passwordController.text == '123'
                ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            )
                : null;
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: usernameController.text.isEmpty ||
                passwordController.text.isEmpty
                ? Colors.grey
                : Color(0xffD53939),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 10.0,
          ),
          child: SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Login",
                      ),
                    ),
                  ],
                ),
                Column(
                  children: const [Icon(Icons.arrow_forward_rounded)],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  //Input Username
  Row getUsernameArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 300,
          child: TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: isError ? Colors.red : Colors.green,
              ),
              labelText: "Username",
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.person_2_sharp,
                color: isError ? Colors.red : Colors.green,
              ),
              suffixIcon: usernameController.text.isEmpty
                  ? Container(
                width: 0,
              )
                  : IconButton(
                onPressed: () => usernameController.clear(),
                icon: Icon(
                  Icons.close_sharp,
                  color: isError ? Colors.red : Colors.green,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.green,
                  width: 2.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.green,
                  width: 2.5,
                ),
              ),
            ),
            onChanged: (text) {
              if (usernameController.text != 'burak') {
                setState(() {
                  isError = true;
                });
              } else {
                setState(() {
                  isError = false;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  //Input Password
  Row getPasswordArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 300,
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: isErrorForPassword ? Colors.red : Colors.green,
              ),
              labelText: "Password",
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.password_sharp,
                color: isErrorForPassword ? Colors.red : Colors.green,
              ),
              suffixIcon: IconButton(
                onPressed: () => setState(
                      () => isPasswordVisible = !isPasswordVisible,
                ),
                icon: isPasswordVisible
                    ? Icon(
                  Icons.visibility_off_sharp,
                  color: isErrorForPassword ? Colors.red : Colors.green,
                )
                    : Icon(
                  Icons.visibility_sharp,
                  color: isErrorForPassword ? Colors.red : Colors.green,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isErrorForPassword ? Colors.red : Colors.green,
                  width: 2.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isErrorForPassword ? Colors.red : Colors.green,
                  width: 2.5,
                ),
              ),
            ),
            keyboardType: TextInputType.number,
            obscureText: isPasswordVisible,
            onChanged: (text) {
              if (passwordController.text != '123') {
                setState(() {
                  isErrorForPassword = true;
                });
              } else {
                setState(() {
                  isErrorForPassword = false;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}