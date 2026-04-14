import unittest
from puzzle_game import PuzzleGame
from invalid_position_exception import InvalidPositionException


class ClasseTestesCoberturadeControle(unittest.TestCase):
    def setUp(self):
        self.pg = PuzzleGame(3)

    def test_caminho1(self):
        tile = 6

        rt = self.pg.move_tile(tile)

        self.assertTrue(rt)

    def test_caminho2(self):
        self.pg._PuzzleGame__dic_positions_of_tiles[9] = (6,7)
        tile = 9

        rt = self.pg.move_tile(tile)

        self.assertFalse(rt)


    def test_caminho3(self):
        tile = 1

        rt = self.pg.move_tile(tile)

        self.assertEqual(self.pg.line_of_empty_position, 3)
        self.assertEqual(self.pg.column_of_empty_position, 3)
        self.assertFalse(rt)

# novo test para move_tile-20
# self.board.put_tile(tile, self.line_of_empty_position, self.column_of_empty_position)
# para
# self.board.put_tile(None, self.line_of_empty_position, self.column_of_empty_position)

# Antes esse mutante ficava vivo porque os testes antigos so verificavam
# o retorno do metodo e a posicao do espaco vazio.
# Eles nao confirmavam se a peca realmente foi colocada no lugar certo.
# Com este teste, verificamos o estado do tabuleiro depois do movimento.
# se o mutante colocar None no lugar da peca, o teste falha e ele morre.
    def test_garatir_peca_foi_movida(self):
        tile = 6

        rt = self.pg.move_tile(tile)

        self.assertTrue(rt)
        self.assertEqual(self.pg.board.grid[1][2], None)
        self.assertEqual(self.pg.board.grid[2][2], 6)


class ClasseTestesCoberturadeDados(unittest.TestCase):
    def setUp(self):
        self.pg = PuzzleGame(3)

    def test_line_column_1(self):
        tl = self.pg.get_tile(2, 2)

        self.assertEqual(tl, 5)

    def test_line_column_2(self):
        tl = self.pg.get_tile(3, 3)

        self.assertEqual(tl, " ")

    def test_line_column_3(self):
        with self.assertRaises(InvalidPositionException):
            tl = self.pg.get_tile(6, 7)

# novo teste para get_tile-1
# if line > 0 and line <= self.board.number_of_lines and \
#    column > 0 AND column <= self.board.number_of_columns:
# para
# if line > 0 and line <= self.board.number_of_lines and \
#    column > 0 OR column <= self.board.number_of_columns:

# Antes esse mutante ficava vivo porque os testes antigos so verificavam
# casos com linha e coluna erradas ao mesmo tempo.
# Com este teste, a linha eh valida e apenas a coluna eh invalida.
    def test_linha_coluna_maior_que_dimensao(self):
        with self.assertRaises(InvalidPositionException):
            tl = self.pg.get_tile(2, 7)

# novo teste para get_tile-4
# if line > 0 and line <= self.board.number_of_lines and \
#    column > 0 and column <= self.board.number_of_columns:
# para
# if line >= 0 and line <= self.board.number_of_lines and \
#    column > 0 OR column <= self.board.number_of_columns:

# Antes esse mutante ficava vivo porque nao existia teste com linha 0.
# por isso, a mudanca de > 0 para >= 0 nao era percebida.
    def test_linha_igual_0(self):
        with self.assertRaises(InvalidPositionException):
            tl = self.pg.get_tile(0, 3)

# novo teste para get_tile-5
# if line > 0 and line <= self.board.number_of_lines and \
#    column > 0 and column <= self.board.number_of_columns:
# para
# if line > 1 and line <= self.board.number_of_lines and \
#    column > 0 OR column <= self.board.number_of_columns:

# Antes esse mutante ficava vivo porque os testes antigos nao usavam
# uma posicao valida na primeira linha.
# com este teste, mostramos que a linha 1 deve ser aceita e retornar
# a peca correta. Se o mutante rejeitar a linha 1, o teste falha.
    def test_linha_igual_1(self):
        tl = self.pg.get_tile(1, 1)
        self.assertEqual(tl, 1)

# novo teste para get_tile-7
# if line > 0 and line <= self.board.number_of_lines and \
#    column > 0 and column <= self.board.number_of_columns:
# para
# if line > 0 and line < self.board.number_of_lines and \
#    column >= 0 OR column <= self.board.number_of_columns:

# Antes esse mutante ficava vivo porque nao havia teste com coluna 0.
# Assim, a alteracao que passa a aceitar coluna 0 nao aparecia.
# Com este teste, garantimos que coluna 0 eh invalida.
    def test_coluna_igual_0(self):
        with self.assertRaises(InvalidPositionException):
            tl = self.pg.get_tile(1, 0)


if __name__ == "__main__":
    unittest.main()

