import 'package:flutter/material.dart';
import 'package:imshy/views/home_view.dart';
import 'package:imshy/views/profile_view.dart';

/*
 * Poderiamos usar de um outro jeito mais simples, utilizando somente
 * a classe main, com rotas nomeadas. Porém ao utilizar o método mais
 * simples não conseguimos passar argumentos dinâmicos sem ser no 
 * próprio método main. Com esta abordagem conseguimos passar todo
 * tipo de argumento!!
 */
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/profile':
        // Valide o tipo certo de dado
        // if (args is String) {
        //  ProfileView(
        //    data: args,
        //  )
        // }
        return MaterialPageRoute(builder: (_) => ProfileView());

      // Se a verificação falhar
      // return _errorRoute();
      default:
        // Se não tiver nenhuma rota com esse nome, mostre um erro
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text("No route")),
          body: Center(child: Text("No route!")));
    });
  }
}
