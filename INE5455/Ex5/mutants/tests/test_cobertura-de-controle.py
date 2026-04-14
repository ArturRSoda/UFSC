import unittest
from puzzle_game import PuzzleGame

class ClasseTestes(unittest.TestCase):

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

if __name__ == "__main__":
    unittest.main()






