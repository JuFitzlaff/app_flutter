import 'package:flutter/material.dart';

// PARTE B - Cookbook "Build a form with validation" com modificacoes
// Original: https://docs.flutter.dev/cookbook/forms/validation
// O exemplo original tem um campo de texto que só verifica se está vazio
// e um botão que mostra um SnackBar. As modificações estão marcadas
// com "MODIFICACAO".

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MODIFICACAO 1: titulo em portugues.
    const appTitle = 'Cadastro com validacao';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: const MyCustomForm(),
      ),
    );
  }
}

// O formulario e um StatefulWidget porque guarda estado (a chave do form
// e os controllers dos campos).
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() => MyCustomFormState();
}

class MyCustomFormState extends State<MyCustomForm> {
  // GlobalKey identifica o Form e permite chamar validate() nele.
  final _formKey = GlobalKey<FormState>();

  // MODIFICACAO 2: controllers para ler o que foi digitado.
  final _nomeController = TextEditingController();
  final _senhaController = TextEditingController();

  // MODIFICACAO 3: controla se a senha aparece ou fica escondida.
  bool _senhaOculta = true;

  @override
  void dispose() {
    // Controllers precisam ser liberados quando a tela e destruida.
    _nomeController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // MODIFICACAO 4: Padding em volta e espacamento entre os campos.
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo NOME (o original tinha um campo sem rotulo).
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
              // validator devolve uma mensagem de erro, ou null se estiver ok.
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Digite seu nome';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // MODIFICACAO 5: campo E-MAIL com regra propria.
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite seu e-mail';
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return 'E-mail invalido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // MODIFICACAO 6: campo SENHA com tamanho minimo e botao de olho.
            TextFormField(
              controller: _senhaController,
              obscureText: _senhaOculta,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _senhaOculta ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    // setState avisa o Flutter para redesenhar a tela.
                    setState(() {
                      _senhaOculta = !_senhaOculta;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'A senha precisa ter pelo menos 6 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // MODIFICACAO 7: campo CONFIRMAR SENHA, comparado com o anterior.
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar senha',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value != _senhaController.text) {
                  return 'As senhas nao sao iguais';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // validate() roda o validator de TODOS os campos.
                    if (_formKey.currentState!.validate()) {
                      // MODIFICACAO 8: mensagem usa o nome digitado.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Cadastro de ${_nomeController.text} realizado!',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
                const SizedBox(width: 16),
                // MODIFICACAO 9: botao que limpa o formulario.
                TextButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    _nomeController.clear();
                    _senhaController.clear();
                  },
                  child: const Text('Limpar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}