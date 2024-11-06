# Protect LABIRAS

**Protect LABIRAS** é um jogo arcade 2D de estratégia que combina elementos dos gêneros **Tower Defense** e **Shooter**, proporcionando uma experiência rápida que testa o planejamento estratégico e os reflexos dos jogadores. O objetivo é defender um muro contra ondas crescentes de inimigos, utilizando uma mecânica simples de clique no mouse, que permite controlar um canhão e ajustar a distância do disparo.

## Principais Mecânicas

- **Controles Simples**: Todas as ações são realizadas com o clique do mouse. Os jogadores controlam a distância do disparo pressionando e segurando o botão esquerdo, liberando para atirar. Essa mecânica simplificada torna o jogo acessível para diversos tipos de público.
  
- **Ondas Progressivas**: Cada nova onda traz mais inimigos, calculados para aumentar a dificuldade de acordo com a fórmula customizada baseada no número da onda. Ondas especiais desbloqueiam novos tipos de inimigos e melhoram propriedades do jogo, como a resistência do muro e o dano do canhão.

- **Profundidade Estratégica**: Os jogadores precisam se adaptar rapidamente, já que a quantidade e os tipos de inimigos evoluem, desafiando-os a desenvolver estratégias ágeis para sobreviver.

## Integração com Banco de Dados

Protect LABIRAS utiliza um banco de dados **CSV** criado no Google Planilhas para gerenciar os atributos dos inimigos, como vida, velocidade e tipo. Esse banco de dados é importado e processado na **Godot Game Engine** usando GDScript, o que permite ajustes dinâmicos nos atributos dos inimigos e facilita a escalabilidade do jogo. Essa abordagem permite atualizações rápidas e manutenção contínua durante o desenvolvimento.

## Tecnologias Utilizadas

- **Godot Game Engine** com GDScript para lógica e mecânicas do jogo.
- **Piskel** para criação de artes em pixel e animações.
- **Notion** para planejamento e controle de tarefas.
- **GitHub** para controle de versão e colaboração.


