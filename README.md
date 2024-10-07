# ⚔ Terminal War ⚔

## 📋 Sobre o projeto

- Terminal War é um jogo desenvolvido na linguagem haskell/prolog como proposta de projeto para a disciplina de Paradigmas de Linguagem de Programação. O projeto foi inspirado no jogo de tabuleiro War com algumas adaptações dadas as limitações de tempo e conhecimentos iniciais.

## 📖 Regras do jogo

Quantidade de jogadores necessárias: 2

- No inicio do jogo, são distribuídos três territórios fixos para os dois jogadores, e uma quantidade fixa de duas tropas também será distribuída para cada um desses territórios. Os territórios que não são de nenhum jogador receberam tropas de números variados que se comportam como exércitos de ocupação (não atacam nenhum outro território, apenas se defendem de ataques realizados pelos jogadores). Após isso, começam as rodadas alternadas entre jogadores.

Em cada rodada, o jogador possui duas fases:

- A fase de distribuir as tropas recebidas no início da rodada, calculadas com base na quantidade de territórios que esse possui, sendo obrigatória a distribuição de todas as tropas dentre os territórios que o jogador tem posse;

- A fase de atacar territórios inimigos ou mover tropas entre os territórios conquistados;

### ⚔ Atacar territórios

- O jogador da vez escolhe de qual território o ataque partirá, qual território inimigo será atacado, com a limitação que só é possível atacar territórios inimigos que são vizinhos do território de onde o ataque partirá, e a quantidade de tropas que atacarão esse território (restrição de no máximo 3 tropas por ataque). Alem disso, o território de onde partirá o ataque deve deixar pelo menos uma de suas tropas fora do ataque, consistindo no exército de ocupação.

- O exército que será atacado deve usar no máximo 3 tropas para defesa, de maneira que o sistema escolherá sempre o máximo de tropas possíveis para o território se defender. A regra do exército de ocupação não se aplica ao território atacado.

- Após a escolha das tropas, cada lado irá rodar uma quantidade de dados equivalente ao número de tropas participando do ataque. Após isso, os maiores resultados dos dois lados irão competir: O maior resultado do dado atacante será comparado ao maior resultado da defesa, caso o resultado do dado atacante seja maior, o mesmo ganha a batalha e a defesa perde uma tropa. Esse ciclo se repete para as tropas restantes, agora com o segundo e depois terceiro maior resultado. O número de batalhas que ocorrem é dado pelo lado com menos tropas participando. Por exemplo, caso a defesa só tenha 2 tropas, mas o ataque tenha 3, ocorrerão 2 batalhas, com os dois maiores resultados do ataque e todos os resultados da defesa. O mesmo se aplica quando o ataque tiver menos tropas do que a defesa.


### 🚶‍♂️ Mover tropas

O jogador pode mover as tropas entre os territórios que estão em sua posse, desde que eles sejam vizinhos um do outro. A partir disso, o jogador terá as opções de:

- Escolher o território de onde partirão as tropas;
- Escolher quantas tropas serão movidas deste território, sendo necessário deixar pelo menos uma tropa nesse, consistindo no exército de ocupação;
- Escolher qual território conquistado receberá essas tropas;

Após as duas fases, a rodada termina e o outro jogador inicia a sua rodada. As condições de vitória são duas:

- Um dos jogadores está sem tropas, sendo a vitória dada ao jogador oponente.
- Um dos jogadores conquistou completamente dois continentes, sendo a vitória dada a esse jogador

## ⚙ Instruções para rodar o jogo

- Após clonar o repositório, basta acessar o respectivo diretório da versão desejada e utilizar um dos comandos abaixo para rodar o projeto.

#### Haskell:

  ```
  cabal install random
  cabal run
  ```

#### Prolog:

  ```
  swipl -q -f './src/Main.pl'
  ```

##### Observação:
- Na versão em prolog, é necessário que os inputs referentes aos territórios sejam inseridos com aspas simples (''), mas não é necessário para os números, além disso, é obrigatório colocar um ponto final (.) ao finalizar a inserção.
