import unittest
from puzzle_game import PuzzleGame
from invalid_position_exception import InvalidPositionException


class ClasseTestesCoberturadeControleOriginal(unittest.TestCase):
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


class ClasseTestesCoberturadeDadosOriginal(unittest.TestCase):
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


if __name__ == "__main__":
    unittest.main()

