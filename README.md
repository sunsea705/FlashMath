# FlashMath

FlashMath - Um Breve Histórico das Versões

O que há de novo? Quais os novos bugs? O que ainda falta? Confira tudo que eu fiz em cada versão do FlashMath.

Por Ítalo Tiago Gomes Souza

0.0.1
- Primeiro modelo funcionando da ideia principal do FlashMath: gerar uma operação matemática em que o usuário deve responder corretamente para acumular pontos.
- Background péssimo
- Gera expressões pseudo-randômicas.
- Conta vidas e pontos perfeitamente.
- Caixa de texto e label gerada pela bibloteca SUIT.	
- Impede o jogador de jogar após ter perdido todas as vidas.

0.0.2
- Background mais bonito.
- Gera expressões aleatórias normalmente, sendo inicialmente apenas nos números de 0 a 10 e operações de somar e subtrair (este é o "Level 1" do jogo).
- Fontes mais bonitas de relógio e pixels.
- Contador de vidas sendo representado por três corações, que mudam quando o jogador perde uma vida.

0.0.3
- Melhorias no design da tela e da posição dos elementos.
- Arquivo conf.lua criado pela primeira vez contendo a largura de 800 pixels e altura de 600, mais o título do jogo, FlashMath.

0.0.4 
- Criado um botão de 'Reset Game', através da biblioteca SUIT, que reinicia o jogo sempre que o usuário desejar. Isso inclui zerar os pontos, zerar a caixa de texto, voltar a ter três vidas (o que elimina a tela de game over na hora) e gerar uma nova expressão aleatória.
- Criado um "jogo secundário" que exibe o protótipo da tela inicial do jogo, exibindo o nome FlashMath. Conta com três botões, Start Game, Insctrutions e Quit Game, sendo este o único botão que funciona, fechando o jogo. O que se espera na próxima versão é que o jogo já esteja divido em vários arquivos separados, para que se faça a ligação entre essa tela e o jogo através de um único main (como no código do "3 - Desafio das Lâmpadas" que pode ser encontrado na pasta "Versões do FlashMath")

0.0.5 (12.11.2017)
-  Implementação radical: O jogo foi dividido em arquivos separados e chamados por um único main. Ou seja, agora o jogo sempre começará na tela inicial criada junto com a versão 0.0.4, através do botão "Start Game". 
- Na tela de jogo também foi incluída um segundo botão ao lado do "Reset Game" chamado de "Back to Main Menu" que como o nome diz, retorna para a tela inicial. 
- Apesar do meu jogo estar parecendo mais com um jogo mesmo, essa coisa de dividir em arquivos deixou o jogo mais lento, mas quem se importa? 
- Alterou-se no arquivo conf.lua a largura do jogo, de 800 pixels para 900, justamente para caber mais outro botão.
- Foi feita uma tentativa de se iniciar um Dialog Box quando o jogador clicar em "Quit Game", no menu inicial, pra realmente confirmar se o jogador deseja sair do jogo. Contudo, a caixa foi criada mas não consegui fazer o jogo fechar através dessa caixa. Ela só consegue fechar a si mesma (ironia). Espera que se na próxima versão já esteja funcionando.
- Na próxima versão também estará implementada o menu de instruções.

0.0.6 (14.11.2017)
- Cronômetro adicionado com sucesso (beta), realizando as funções básicas de acordo com a proposta do jogo: Começando com 15 segundos e descresecendo até 0. Se chegar a zero, o usuário perde uma vida automaticamente. Ao clicar para reiniciar o jogo, o cronômetro é reiniciado também, e se o jogador perder todas as vidas o cronômetro permanece zerado até que se reinicie o jogo.
- Inserido a funcionalidade de clique com o enter do teclado numérico.
- DialogBox funcionando 95%, falta deixar a caixinha como sendo a única janela a ser possível a ser mexida, pois mesmo que ela esteja ativa é possível voltar a tela do jogo.
- O menu de instruções não foi implementado novamente porque fiquei ocupado demais agora com a lógica da dificuldade crescente e acabei esquecendo. Vou lembrar de não colocar o que vai ter na próxima versão pra evitar apontamentos como este.

0.0.7 (21.11.2017)
- Lógica da dificuldade crescente no jogo adicionada com sucesso, na sua versão beta, através de funções sendo duas e divididas em arquivos separados. Contudo ainda funciona para apenas três grupos de operações, futuramente ainda vou dividir essas operações também em funções para o melhor controle. 
- Há um problema com a divisão pois necessito de algum mecanismo de controle que gere para mim uma divisão exata e bonitinha, o que pela versão atual é bastante difícil.
- O que importa agora que todos os requisitos básicos do FlashMath foram atendidos: 1) Meu jogo gera expressões aleatórias 2)Em que você deve responder em 15 segundos senão perde uma vida 3)A dificuldade vai aumentando progressivamente conforme mais expressões você vai resolvendo.
- Melhorias na sintaxe do código, leves modificações para deixá-lo mais elegante. 
- E sim, finalmente, um pouco do menu de instruções foi criado. Ainda que não funcione totalmente, já é algo a ser mostrado. As tentativas de ler arquivos de texto falharam o que resultou em várias e várias strings grandes no meu código.

0.0.8 (23.11.2017)
- Menu de instruções quase totalmente implementado, ele tem quatro botões que levam a diferentes textos, claro, sendo gerados por strings gigantes mas é o que temos. Ainda falta só um menu de instruções para se colocar o texto mas é coisa rápida. O principal do principal mesmo que era os comandos básicos e regras já está todo escrito e bonitinho.
- Dificuldade progressiva FINALMENTE está completa. Sim, resolvi o problema da divisão de uma maneira elegantemente linda. Agora, tanto os números, o operador e a expressão geradas aleatoriamente são feitas através de uma função separada chamada operacionando.lua. Agora há uma rede intercalada de funções já que se chama a level_up() que chama dificulteando() e por fim operacionando(). Mais beleza que isso só minha namorada.
- Adicionado a tão esperada primeira animação do FlashMath. Não é bem uma animação, é só que o background agora se move inifinitamente dando um efeito bonitinho. Ainda falta implementar em todas as opções (por enquanto só está na tela inicial).
- Adicionado parcialmente um retorno de erros para o usuário. Basicamente, o jogo, após o jogador perder as suas três vidas mostra quais expressões que ele errou, qual a resposta correta e qual foi a resposta dada pelo usuário. Toperson, hein? Só que o código pra fazer isso ficou simplesmente péssimo. Na próxima versão estará implementada essa funcionalidade em forma de função separada.
- Isso tecnicamente põe fim ao esqueleto do Precisão/Arcade. Agora o resto são só detalhes visuais que estarão implementados na próxima versão. (assim espero)  

0.0.9 (03.12.2017)
- Função "errowando.lua" criada com sucesso. Graças a isso pude economizar mais ou menos umas 15 linhas de código inúteis e separei elas nessa função lindíssima. 
- Background animado lindíssimo também agora funcionando perfeitamente, com velocidade controlada e sem bugs. 
- Backgrounds adicionados, são bem simples, mas ao menos não atrapalham o que é importante no jogo.
- Interface bem mais trabalhada, agora com o tão esperado menus para cada modo. Cada modo fica em um retângulo próprio e através da função retangulando() ele muda o texto da descrição e o background do modo a ser mostrado depedendo em qual local o mouse estiver. As cores para cada modo são características, vermelho, azul e verde.
- Outros elementos da interface foram acabados, como a pontuação e a posição dos botões.
- Não que seja importante para o game, mas a organização interna das pastas e dos arquivos agora está muito mais organizada e limpinha. Parece até profissional. 
- Ainda com relação a parte decorativa planejo colocar músicas e efeito de Fade In/Out mas por hora é o momento de desenvolver os outros modos pois o tempo está escasso agora. Que venha a versão 0.0.10!

0.0.10 (04.12.2017)
- Melhoria no design dos modos, adicionado um ícone para cada modo e seu sub-modo para deixar o jogo mais atraente.
- Mas o principal é: O segundo modo do FlashMath, finalmente, após 9 versões está pronto: Time Attack! Agora existe uma outra maneira de jogar em que o usuário tem 1min30s para acertar o maior números de expressões que ele conseguir dentre esse tempo e não pode errar uma única vez. O trabalho que deu foi formatar o relógio para que ele exibisse corretamente o 1min30 decrescendo, precisei usar dois cronômetros trabalhando separados, mas funcionou. Agora tenho tudo para trabalhar no próximo modo, o Wisdom. 

0.0.11 (09.12.2017)
- Depois de tanto sacríficio e paciência, o terceiro modo do FlashMath está pronto: Wisdom Arcade! O mais impressionante que o mais difícil de se fazer isso não foi a lógica mas só a impressão dos elementos da tela. O código está gigantesco. 
- Agora tenho um modo que é contraparte do Precision, pois vai aparecer na tela uma expressão no formato "2 + 3 >= 7 - 1" e então o jogador deve responder verdadeiro ou falso. A medida que o jogador vá acertando (no nível 4, especificamente), começarão a aparecer expressões mais complexas no estilo "2 + 3 > 7 - 1 and not 6 + 1 == 7 - 0", envolvendo aqueles operadores lógicos.
- Fazer esse modo foi mais fácil do que o Precision mas a quantidade de linhas está absurda, porém estou sem paciência no momento para melhorá-lo. Hora de fazer o próximo modo do FlashMath que é o Time Attack do Wisdom.

0.0.12 (10.12.2017)
- Bem tranquilo, fácil e prático: Time Attack do Wisdom está prontíssimo. Agora tenho quatro modos jogáveis e muito legais.

0.0.13 (15.12.2017)
- E com isso, encerro a primeira parte do FlashMath. Menu de créditos está pronto, significa que é hora do adeus, por enquanto. Há ainda muito trabalho a ser feito, mas o tempo não deu de jeito nenhum, então.
