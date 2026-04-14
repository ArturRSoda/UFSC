# Entrega - Exercicio 5 - Testes de Mutacao

## 1. Testes executados na primeira execucao do Mutmut

Na primeira execucao do Mutmut, foram considerados apenas os testes originais do projeto.

Comando usado para validar os testes originais:

```bash
PYTHONPATH=src pytest tests -q
```

Resultado:

```text
6 passed in 0.01s
```

Testes originais executados:

- `tests/test_cobertura-de-controle.py::test_caminho1`
- `tests/test_cobertura-de-controle.py::test_caminho2`
- `tests/test_cobertura-de-controle.py::test_caminho3`
- `tests/test_cobertura-de-dados.py::test_line_column_1`
- `tests/test_cobertura-de-dados.py::test_line_column_2`
- `tests/test_cobertura-de-dados.py::test_line_column_3`

Comando usado para a primeira execucao do Mutmut:

```bash
PYTHONPATH=src mutmut run
```

Resumo da primeira execucao:

```text
646/646  173 killed  438 no tests  35 survived
```

## 2. Mutantes que nao foram mortos na primeira execucao

Entre todos os mutantes vivos da primeira execucao, os 5 mutantes selecionados para este trabalho foram:

- `puzzle_game.x|PuzzleGame|get_tile__mutmut_1`
- `puzzle_game.x|PuzzleGame|get_tile__mutmut_4`
- `puzzle_game.x|PuzzleGame|get_tile__mutmut_5`
- `puzzle_game.x|PuzzleGame|get_tile__mutmut_7`
- `puzzle_game.x|PuzzleGame|move_tile__mutmut_20`

Explicacao simples de por que eles ficaram vivos:

1. `get_tile__mutmut_1`
O mutante troca `and` por `or` na validacao da coluna. Ele ficou vivo porque os testes antigos so verificavam um caso em que linha e coluna estavam erradas ao mesmo tempo. Nao existia teste com linha valida e apenas coluna invalida.

2. `get_tile__mutmut_4`
O mutante troca `line > 0` por `line >= 0`. Ele ficou vivo porque nao havia teste usando linha 0.

3. `get_tile__mutmut_5`
O mutante troca `line > 0` por `line > 1`. Ele ficou vivo porque os testes antigos nao verificavam uma posicao valida na primeira linha.

4. `get_tile__mutmut_7`
O mutante troca `column > 0` por `column >= 0`. Ele ficou vivo porque nao existia teste usando coluna 0.

5. `move_tile__mutmut_20`
O mutante troca a insercao da peca por `None` no movimento. Ele ficou vivo porque os testes antigos verificavam o retorno do metodo e a posicao do espaco vazio, mas nao verificavam o estado final do tabuleiro.

Outros mutantes vivos da primeira execucao em `puzzle_game.py`:

- `puzzle_game.x|PuzzleGame|__generate_list_of_tiles____mutmut_3`
- `puzzle_game.x|PuzzleGame|__generate_list_of_tiles____mutmut_12`
- `puzzle_game.x|PuzzleGame|__put_tiles_in_the_board____mutmut_25`
- `puzzle_game.x|PuzzleGame|__put_tiles_in_the_board____mutmut_26`
- `puzzle_game.x|PuzzleGame|__put_tiles_in_the_board____mutmut_27`
- `puzzle_game.x|PuzzleGame|__put_tiles_in_dic_positions____mutmut_12`
- `puzzle_game.x|PuzzleGame|__put_tiles_in_dic_positions____mutmut_20`
- `puzzle_game.x|PuzzleGame|__put_tiles_in_dic_positions____mutmut_21`
- `puzzle_game.x|PuzzleGame|get_tile__mutmut_2`
- `puzzle_game.x|PuzzleGame|get_tile__mutmut_8`
- `puzzle_game.x|PuzzleGame|get_tile__mutmut_10`

## 3. Novos testes que matam os 5 mutantes selecionados

Depois, foram adicionados 5 novos testes dentro da pasta `tests/`.

Comando usado para validar a suite atual:

```bash
PYTHONPATH=src pytest tests -q
```

Resultado:

```text
11 passed in 0.01s
```

Relacao entre cada novo teste e o mutante que ele mata:

1. `tests/test_cobertura-de-dados.py::test_linha_coluna_maior_que_dimensao`
Mata o mutante `get_tile__mutmut_1`.
Esse teste usa uma linha valida e uma coluna invalida. Assim, se o mutante trocar `and` por `or`, ele aceita uma posicao errada e o teste falha.

2. `tests/test_cobertura-de-dados.py::test_linha_igual_0`
Mata o mutante `get_tile__mutmut_4`.
Esse teste verifica que linha 0 deve ser invalida. Se o mutante aceitar linha 0, ele nao levanta excecao e morre.

3. `tests/test_cobertura-de-dados.py::test_linha_igual_1`
Mata o mutante `get_tile__mutmut_5`.
Esse teste verifica que a linha 1 deve ser aceita. Se o mutante rejeitar a primeira linha, o valor retornado nao sera o esperado e ele morre.

4. `tests/test_cobertura-de-dados.py::test_coluna_igual_0`
Mata o mutante `get_tile__mutmut_7`.
Esse teste verifica que coluna 0 deve ser invalida. Se o mutante aceitar coluna 0, ele nao levanta excecao e morre.

5. `tests/test_cobertura-de-controle.py::test_garatir_peca_foi_movida`
Mata o mutante `move_tile__mutmut_20`.
Esse teste verifica o estado final do tabuleiro depois do movimento. Se o mutante colocar `None` no lugar da peca, a verificacao do tabuleiro falha e ele morre.

## 4. Mutantes que permanecem vivos apos a nova execucao do Mutmut

Comando usado:

```bash
PYTHONPATH=src mutmut run
mutmut results
```

Resumo da nova execucao:

```text
646/646  183 killed  438 no tests  25 survived
```

Importante: os 5 mutantes selecionados nao aparecem mais entre os mutantes vivos. Portanto, eles foram mortos pelos novos testes.

Mutantes que continuam vivos em `puzzle_game.py`:

- `puzzle_game.x|PuzzleGame|__generate_list_of_tiles____mutmut_3`
- `puzzle_game.x|PuzzleGame|__generate_list_of_tiles____mutmut_12`
- `puzzle_game.x|PuzzleGame|__put_tiles_in_the_board____mutmut_25`
- `puzzle_game.x|PuzzleGame|__put_tiles_in_the_board____mutmut_26`
- `puzzle_game.x|PuzzleGame|__put_tiles_in_the_board____mutmut_27`
- `puzzle_game.x|PuzzleGame|__put_tiles_in_dic_positions____mutmut_20`
- `puzzle_game.x|PuzzleGame|__put_tiles_in_dic_positions____mutmut_21`
- `puzzle_game.x|PuzzleGame|get_tile__mutmut_10`

Outros mutantes que continuam vivos em `board.py`:

- `board.x|Board|__init____mutmut_6`
- `board.x|Board|is_inside_the_board__mutmut_1`
- `board.x|Board|is_inside_the_board__mutmut_2`
- `board.x|Board|is_inside_the_board__mutmut_3`
- `board.x|Board|is_inside_the_board__mutmut_4`
- `board.x|Board|is_inside_the_board__mutmut_7`
- `board.x|Board|positions_are_adjacent__mutmut_12`
- `board.x|Board|positions_are_adjacent__mutmut_13`
- `board.x|Board|positions_are_adjacent__mutmut_14`
- `board.x|Board|positions_are_adjacent__mutmut_15`
- `board.x|Board|positions_are_adjacent__mutmut_16`
- `board.x|Board|positions_are_adjacent__mutmut_17`
- `board.x|Board|positions_are_adjacent__mutmut_18`

## 5. Conclusao

Os novos testes adicionados conseguiram matar exatamente os 5 mutantes escolhidos:

- `get_tile__mutmut_1`
- `get_tile__mutmut_4`
- `get_tile__mutmut_5`
- `get_tile__mutmut_7`
- `move_tile__mutmut_20`

Assim, a suite passou de 6 para 11 testes, e o numero total de mutantes vivos caiu de 35 para 25.

Se for necessario destacar apenas a classe `PuzzleGame`, a reducao foi de 16 mutantes vivos para 8 mutantes vivos.
