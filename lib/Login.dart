import 'package:flutter/material.dart';
import 'package:nss/Api/loginapi.dart';
import 'package:nss/Home.dart';
import 'package:nss/Register.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title: Text("LoginScreen"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(
//                 hintText: "UserName",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 5),
//             TextFormField(
//               decoration: InputDecoration(
//                 hintText: "Password",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(onPressed: (){}, child:Text("Login") ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 80, color: Color(0xFF1565C0)),
                const SizedBox(height: 20),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Login to continue',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 30),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter your email' : null,
                ),
                const SizedBox(height: 20),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter your password' : null,
                ),
                const SizedBox(height: 30),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed:() {
                      Loginapi(email:_emailController.text,password: _passwordController.text,context: context );
                    },
                    child:
                        
                         const Text('Login', style: TextStyle(fontSize: 18)),
                  ),
                ),

                const SizedBox(height: 20),
                TextButton(
                  onPressed: () =>{ Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterForm()),) },
                  child: const Text(
                    'Register Now',
                    style: TextStyle(color: Color.fromARGB(255, 37, 58, 82)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}