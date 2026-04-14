import unittest
from src.puzzle_game import PuzzleGame

class ClasseTestes(unittest.TestCase):

    def setUp(self):
        self.pg = PuzzleGame(3)

    def test_caminho1(self):
        tl = self.pg.get_tile(2, 2)

        self.assertEqual(tl, 5)

if __name__ == "__main__":
    unittest.main()






