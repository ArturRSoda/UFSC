import unittest
from puzzle_game import PuzzleGame
from invalid_position_exception import InvalidPositionException

class ClasseTestes(unittest.TestCase):

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






