// importa a biblioteca para trabalalar com numeros aleatorios isso vai sser utilizado no dado
import 'dart:math';
// <<<<<<<<<<<<<<<<------------------------------------------------------>>>>>>>>>>
// a linha de baixo vai ser o import ddo pacote principal do flutter
import 'package:flutter/material.dart';

// 1. estrutura da base do app
// a função principal que inicia o app

void main() => runApp(const AplicativoJogodeDados());

class AplicativoJogodeDados extends StatelessWidget {
  const AplicativoJogodeDados({super.key});

  @override
  Widget build(BuildContext context) {
    //fazer um return do materialApp que da o visual ao projet
    return MaterialApp(
      title: 'jogo de dados', //Titulo que aparece no gerenciador
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TelaConfiguracaoJogadores(),
    );
  }
}

//2. tela de configuraçoes de jogadores
// a primeira tela do app. coletar os nomes dos jogadores
class TelaConfiguracaoJogadores extends StatefulWidget {
  const TelaConfiguracaoJogadores({super.key});

  @override
  //cria o objeto de estado que vai gerenciar o formulario do jogador
  State<TelaConfiguracaoJogadores> createState() =>
      _EstadoTelaConfiguracaoJogadores();
}

class _EstadoTelaConfiguracaoJogadores
    extends State<TelaConfiguracaoJogadores> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("configuração dos jogadores")),
      body: Padding(
        padding: const EdgeInsets.all(16), //Espacamento interno
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
              const Spacer(), //ocupar o espaço disponivel verticalmente  empurranado o botao
              //o botao para baixp
              ElevatedButton(
                onPressed: () {
                  if (_chaveFormulario.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaJogodeDados(
                          nomeJogador1: _controladorJogador1.text,
                          nomeJogador2: _controladorJogador2.text,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("iniciar jogo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//tela principal do jogo
//aqui eu vou receber os nomes como propiedades
class TelaJogodeDados extends StatefulWidget{
//  variaveis finais que armazenam os nomes recebidos da tela anterior
  final String nomeJogador1;
  final String nomeJogador2;
//TELADEJOGODEDADOS   E O CORPO DE UM ROBO  
  const TelaJogodeDados({
    super.key,
    //o required garente que esses valores devem ser passados
    required this.nomeJogador1,
    required this.nomeJogador2,
    
    }
    );
    @override
    // quando essa tela for criada use essa classe chamada estadotelajogodedados 
    //para guardar e controçar o estado dela
    // -----------------------------------------------------------
    //estadotelajogodedaos e o cerebro do robo que guarda o que esta acontecendo
    //o createstate e o botao que coloca o cerebro dentro do robo
    State<TelaJogodeDados>createState() => _EstadoTelaJogodeDados();
  }

  class _EstadoTelaJogodeDados extends State<TelaJogodeDados>{
    final Random _aleatorio = Random();//gerado de numeros aleatorios
    //lista dos 3 valores de cada jogador
    List<int> _lancamentosjogador1 = [1,1,1];
    List<int> _lancamentosjogador2 = [1,1,1];
    String _mensagemResultado = ''; //mensagem de resultado da rodada

    //mapear as associaçoes do numero dado referente ao link
    final Map<int, String> imagensDados = {
      1: 'https://i.imgur.com/1xqPfjc.png',
      2: 'https://i.imgur.com/5ClIegB.png',
      3: 'https://i.imgur.com/hjqY13x.png',
      4: 'https://i.imgur.com/CfJnQt0.png',
      5: 'https://i.imgur.com/6oWpSbf.png',
      6: 'https://i.imgur.com/drgfo7s.png',

    };
 
    // logica da pontuacao: verifica combinacao para aplicar multiplicadores
    int _calcularPontuacao(List<int> lancamentos){
      //reduce percorre toda a lista somando tudo
      final soma = lancamentos.reduce((a,b) => a+b);
      // [4,4,1] > 4+4 = 8 > 8 + 1 =9 >soma = 9
      final valoresUnicos = lancamentos.toSet().length;
      //toset remove repetidos
      if(valoresUnicos ==1){//exemplo [5,5,5]. tres iguais igual o triplo da soma
         return soma * 3;   
            }else if(valoresUnicos == 2){//ex [4,4,1] dois igausi ao dobro da soma
            return soma;
          }
    }
//function chamada pelo botao  para lancar os dados
    void _lancarDados(){//EU USO O sublinhado significa que ela e privada so pode ser usada
    //dentro dessa classe
    //comando crucial p/ forçar a atualizacao na tela
   setState(() {
     _lancamentosjogador1 = List.generate(3,(_) => _aleatorio.nextInt(6)+1);
     _lancamentosjogador2 = List.generate(3,(_) => _aleatorio.nextInt(6)+1);

     final pontuacao1 = _calcularPontuacao(_lancamentosjogador1);
     final pontuacao2 = _calcularPontuacao(_lancamentosjogador2);

if(pontuacao1 > pontuacao2){
  _mensagemResultado = '${widget.nomeJogador1} venceu! ($pontuacao1 x $pontuacao2)';
 }else if(pontuacao2 > pontuacao1){
  _mensagemResultado = '${widget.nomeJogador1} venceu! ($pontuacao2 x $pontuacao1)';
 }else{
  _mensagemResultado = 'Empate! joguem novamente';
 }
   });
   
   Widget _construirColunaJogador(String nome, List<int> lancamento){
    return Expanded(//pega todo espaço disponivel dentro de um row colunm 
      child: Column(
        children: [
          Text(nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,//é o justify content center do css
            children: lancamento.map((valor){
              //map trasformar o numero do dado em um widget
              return Padding(
                padding: const EdgeInsets.all(4.0),
               child: image.network(
                imagensDados[valor]!,
                width:50,
                height:50,
                errorBuilder: (context,erro, stackTrace)=>
                const Icon(Icons.error,size:40),
               ),
              )
            })
          )
        ],
      )
    )
   }
   }
  }