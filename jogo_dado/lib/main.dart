// importa a biblioteca para trabalalar com numeros aleatorios isso vai sser utilizado no dado
import 'dart:math';
// <<<<<<<<<<<<<<<<------------------------------------------------------>>>>>>>>>>
// a linha de baixo vai ser o import ddo pacote principal do flutter
import 'package:flutter/material.dart';

// 1. estrutura da base do app
// a função principal que inicia o app

void main() => runApp(
  const AplicativoJogodeDados()
);

class AplicativoJogodeDados extends StatefulWidget{
  const AplicativoJogodeDados({super.key});


@override
Widget build(BuildContext){
//fazer um return do materialApp que da o visual ao projet
return MaterialApp(
  title: 'jogo de dados',//Titulo que aparece no gerenciador
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
   home: const TelaConfiguracaoJogadores(),
  );
 }
}

//2. tela de configuraçoes de jogadores
// a primeira tela do app. coletar os nomes dos jogadores
class TelaConfiguracaoJogadores  extends StatefulWidget {
  const TelaConfiguracaoJogadores({super.key});

@override
//cria o objeto de estado que vai gerenciar o formulario do jogador
 State<TelaConfiguracaoJogadores> createState() => _EstadoTelaConfiguracaoJogadores();
}

class _EstadoTelaConfiguracaoJogadores extends State<TelaConfiguracaoJogadores>{
  // chave global para indetificar e validar o widget
  //final é uma palavra chave do dart para criar uma variavel que so recebe valor uma vez
  // ------------------------------------------------------------------------------------
  //formState e o estado interno desse formulario é a parte que sabe oque
  // esta digitado e consegue validar os campos
  final _chaveFormulario = GlobalKey<FormState>();
  //controladores para pegar o texto digitado nos campos 
  final TextEditingController _controladorJogador1 = TextEditingController();
  final TextEditingController _controladorJogador2 = TextEditingController();
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:const Text("configuração dos jogadores")
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),//Espacamento interno
        child: Form(
          key: _chaveFormulario,
          child: Column(
            children: [
              //campo de texto pata jogador numero 1
              TextFormField(
                controller: _controladorJogador1,
                decoration: const InputDecoration(labelText: "nome jogador 1"),
                validator: (valor) => valor!.isEmpty ? "digite um nome" : null,
              ),
 
                 const SizedBox(height: 16),
              //campo de texto pata jogador numero 2
              TextFormField(
                controller: _controladorJogador2,
                decoration: const InputDecoration(labelText: "nome jogador 2"),
                validator: (valor) => valor!.isEmpty ? "digite um nome" : null,
              ),
              const Spacer(),//ocupar o espaço disponivel verticalmente  empurranado o botao
              //o botao para baixp
             ElevatedButton(
              onPressed: (){
                if(_chaveFormulario.currentState!.validate()){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) => TelaJogoDados(
                        nomeJogador1: _controladorJogador1.text,
                        nomeJogador2: _controladorJogador2.text,
                      ),
                      ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity,50)),
              child: const Text("iniciar jogo"),
              )

            ],
          ),
        ),
      ),
    );
  }
}

