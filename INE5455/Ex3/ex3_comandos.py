import unittest
from src.puzzle_game import PuzzleGame

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



if __name__ == "__main__":
    unittest.main()






