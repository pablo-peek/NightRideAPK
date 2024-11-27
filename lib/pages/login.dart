import 'package:flutter/material.dart';

import '../controllers/loginController.dart';
import 'register.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({super.key});

  @override
  _LoginFormPageState createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  final LoginController _controller = LoginController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ingresar",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Bungee',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade900,
                Colors.black,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/tipography.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _controller.formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Título "Iniciar Sesión"
                              Text(
                                "Iniciar Sesión",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Bungee',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16),

                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: "Correo electrónico",
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                ),
                                style: TextStyle(color: Colors.black),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Por favor, ingrese su correo electrónico.";
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                      .hasMatch(value)) {
                                    return "Ingrese un correo electrónico válido.";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),

                              TextFormField(
                                controller: _passwordController,
                                obscureText: !_controller.isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: "Contraseña",
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _controller.isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.deepPurple,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _controller.isPasswordVisible = !_controller.isPasswordVisible;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                ),
                                style: TextStyle(color: Colors.black),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Por favor, ingrese su contraseña.";
                                  }
                                  if (value.length < 6) {
                                    return "La contraseña debe tener al menos 6 caracteres.";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),

                              // Botón de inicio de sesión
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: () {
                                  _controller.login(
                                    context,
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                },
                                child: Text(
                                  "Iniciar Sesión",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Bungee',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),

                              // Enlace de registro
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "¿No tienes cuenta? ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RegisterPage()),
                                      );
                                    },
                                    child: Text(
                                      "Regístrate",
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Spacer(),

                Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  color: Colors.grey.shade900,
                  child: Text(
                    "Todos los derechos reservados © Robust",
                    style: TextStyle(
                      fontFamily: 'Bungee',
                      fontSize: 12,
                      color: Colors.white,
                    ),
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