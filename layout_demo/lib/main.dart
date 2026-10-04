import 'package:flutter/material.dart';
// PARTE A - Layout do tutorial do Flutter
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Flutter layout demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        // SingleChildScrollView permite rolar a tela se o conteudo nao couber.
        body: const SingleChildScrollView(
          // Column empilha os filhos de cima para baixo.
          child: Column(
            children: [
              ImageSection(image: 'images/lake.jpg'),
              TitleSection(
                name: 'Oeschinen Lake Campground',
                location: 'Kandersteg, Switzerland',
              ),
              ButtonSection(),
              TextSection(
                description:
                    'O lago Oeschinen fica nos Alpes Berneses, na Suiça, a '
                    'mais de 1.500 metros de altitude. Para chegar, pega-se '
                    'um teleférico em Kandersteg e depois uma caminhada de '
                    'cerca de meia hora por pastos e floresta de pinheiros. '
                    'No verão é possível remar no lago e descer de tobogã.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------- Secao da imagem ----------
class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    // BoxFit.cover: a imagem preenche todo o espaco, cortando o excesso.
    return Image.asset(image, width: 600, height: 240, fit: BoxFit.cover);
  }
}

// ---------- Secao do titulo ----------
class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.name, required this.location});

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          // Expanded faz a coluna de textos ocupar todo o espaco livre da
          // linha, empurrando a estrela e o numero para a direita.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(location, style: TextStyle(color: Colors.grey[500])),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const Text('41'),
        ],
      ),
    );
  }
}

// ---------- Secao dos botoes ----------
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        // spaceEvenly distribui o espaco livre igualmente entre os botoes.
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWithText(color: color, icon: Icons.call, label: 'CALL'),
          ButtonWithText(color: color, icon: Icons.near_me, label: 'ROUTE'),
          ButtonWithText(color: color, icon: Icons.share, label: 'SHARE'),
        ],
      ),
    );
  }
}

// Widget reutilizavel: um icone em cima e um texto embaixo.
class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------- Secao do texto ----------
class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      // softWrap: o texto quebra de linha ao chegar na borda.
      child: Text(description, softWrap: true),
    );
  }
}