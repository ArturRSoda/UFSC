import unittest
from src.puzzle_game import PuzzleGame
from src.invalid_position_exception import InvalidPositionException

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

if __name__ == "__main__":
    unittest.main()






