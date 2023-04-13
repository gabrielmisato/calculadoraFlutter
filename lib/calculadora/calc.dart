import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String numeroTela = '';
  String operacao = '';

  double primeiroValor = 0;
  double resultado = 0;
  int qtdVirgula = 0;
  int resultadoFormatado = 0;

  void _calcular(String botao) {
    switch (botao) {
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
      case ',':
        setState(() {
          qtdVirgula = numeroTela.split(',').length - 1;

          if (qtdVirgula == 0) {
            numeroTela += botao;
            if (numeroTela.startsWith(',')) {
              numeroTela = '0$numeroTela';
            }
          } else if (qtdVirgula == 1) {
            if (botao == ',') {
              print('Erro: Mais de uma vírgula encontrada!');
            } else {
              numeroTela += botao;
            }
          }
        });
        break;

      // ========== OPERAÇÕES ==========
      case '+':
      case '-':
      case 'X':
      case '/':
        operacao = botao;
        numeroTela = numeroTela.replaceAll(',', '.');
        primeiroValor = double.parse(numeroTela);
        numeroTela = numeroTela.replaceAll('.', ',');
        setState(() {
          numeroTela = '';
        });
        break;

      // ========== IGUAL ==========
      case '=':
        numeroTela = numeroTela.replaceAll(',', '.');
        if (operacao == '+') {
          resultado = primeiroValor + double.parse(numeroTela);
        } else if (operacao == '-') {
          resultado = primeiroValor - double.parse(numeroTela);
        } else if (operacao == 'X') {
          resultado = primeiroValor * double.parse(numeroTela);
        } else if (operacao == '/') {
          if (double.parse(numeroTela) == 0) {
            print('Erro: Divisão por 0!');
          } else {
            resultado = primeiroValor / double.parse(numeroTela);
          }
        }

        String resultadoString = resultado.toString();
        List<String> resultadoPartes = resultadoString.split('.');
        if (int.parse(resultadoPartes[1]) * 1 == 0) {
          resultadoFormatado = int.parse(resultadoPartes[0]);
          setState(() {
            numeroTela = resultadoFormatado.toString();
          });
        } else {
          setState(() {
            numeroTela = resultado.toString();
            numeroTela = numeroTela.replaceAll('.', ',');
          });
        }
        break;

      case '<-':
        setState(() {
          if (numeroTela.isNotEmpty) {
            numeroTela = numeroTela.substring(0, numeroTela.length - 1);
          }
        });
        break;

      case 'AC':
        setState(() {
          primeiroValor = 0;
          numeroTela = '';
        });
        break;
    }
  }

  Widget criarBotao(
      String text, Color color, Color textColor, VoidCallback function) {
    return SizedBox(
      width: 80,
      height: 80,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: const CircleBorder(),
        ),
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(100, 8, 8, 8),
      // ========== APPBAR ==========
      appBar: AppBar(
        title: const Center(
          child: Text('Calculadora'),
        ),
      ),

      // ========== BODY =============
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // ========== LINHA 1 ==========
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                numeroTela,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              )
            ],
          ),
          // ========== LINHA 2 =========
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              criarBotao(
                  'AC',
                  Colors.black,
                  const Color.fromARGB(255, 201, 131, 25),
                  () => _calcular('AC')),
              criarBotao(
                  '<-',
                  Colors.black,
                  const Color.fromARGB(255, 30, 173, 20),
                  () => _calcular('<-')),
            ],
          ),
          // ========== LINHA 3 ==========
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              criarBotao(
                  '7', Colors.white30, Colors.white, () => _calcular('7')),
              criarBotao(
                  '8', Colors.white30, Colors.white, () => _calcular('8')),
              criarBotao(
                  '9', Colors.white30, Colors.white, () => _calcular('9')),
              criarBotao('/', Colors.white30,
                  const Color.fromARGB(255, 30, 173, 20), () => _calcular('/')),
            ],
          ),
          // ========== LINHA 4 ==========
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              criarBotao(
                  '4', Colors.white30, Colors.white, () => _calcular('4')),
              criarBotao(
                  '5', Colors.white30, Colors.white, () => _calcular('5')),
              criarBotao(
                  '6', Colors.white30, Colors.white, () => _calcular('6')),
              criarBotao('X', Colors.white30,
                  const Color.fromARGB(255, 30, 173, 20), () => _calcular('X')),
            ],
          ),
          // ========== LINHA 5 ==========
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              criarBotao(
                  '1', Colors.white30, Colors.white, () => _calcular('1')),
              criarBotao(
                  '2', Colors.white30, Colors.white, () => _calcular('2')),
              criarBotao(
                  '3', Colors.white30, Colors.white, () => _calcular('3')),
              criarBotao('-', Colors.white30,
                  const Color.fromARGB(255, 30, 173, 20), () => _calcular('-')),
            ],
          ),
          // ========== LINHA 6 ==========
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              criarBotao(
                  '0', Colors.white30, Colors.white, () => _calcular('0')),
              criarBotao(
                  ',', Colors.white30, Colors.white, () => _calcular(',')),
              criarBotao('=', const Color.fromARGB(255, 30, 173, 20),
                  Colors.white, () => _calcular('=')),
              criarBotao('+', Colors.white30,
                  const Color.fromARGB(255, 30, 173, 20), () => _calcular('+')),
            ],
          ),
        ],
      ),
    );
  }
}
