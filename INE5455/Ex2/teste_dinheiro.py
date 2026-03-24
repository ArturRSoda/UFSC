import unittest

from dinheiro import Dinheiro, Moeda

class TesteDinheiro(unittest.TestCase):
    def test_criacao_dinheiro_menos_100_centavos(self):
        # INLINE FIXTURE SETUP
        # EXERCISE SUT
        din = Dinheiro(Moeda.BRL, 10, 50)
        # RESULT VERIFICATION
        self.assertEqual(Moeda.BRL, din.moeda)
        self.assertEqual(10, din.inteiro)
        self.assertEqual(50, din.fracionado)
        # TEARDOWN FIXTURES

    def test_criacao_sem_normalizar_mais_100_centavos(self):
        # INLINE FIXTURE SETUP
        # EXERCISE SUT
        din = Dinheiro(Moeda.BRL, 10, 101)
        # RESULT VERIFICATION
        self.assertEqual(Moeda.BRL, din.moeda)
        self.assertEqual(11, din.inteiro)
        self.assertEqual(1, din.fracionado)
        # TEARDOWN FIXTURES

    def test_quantia_em_escala(self):
        # INLINE FIXTURE SETUP
        din = Dinheiro(Moeda.USD, 111, 22)
        # EXERCISE SUT
        din_sem_escala = din.obter_quantia_em_escala()
        # RESULT VERIFICATION
        self.assertEqual(11122, din_sem_escala)
        # TEARDOWN FIXTURES


