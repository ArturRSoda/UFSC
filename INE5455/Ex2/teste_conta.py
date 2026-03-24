import unittest

from agencia import Agencia
from conta import Conta
from dinheiro import Moeda
from banco import Banco
from transacao import *

class TesteConta(unittest.TestCase):

    def setUp(self):
        self.b = Banco("Banco_Bango", Moeda.BRL)
        self.ag = self.b.criar_agencia("Agencia_Bungo")
        self.ct = self.ag.criar_conta("Bingo")

    def test_criacao_por_construtor(self):
        # IMPLICT FIXTURE SETUP
        # EXERCISE SUT
        ct = Conta("Bingo", 1, self.ag)
        # RESULT VERIFICATION
        self.assertEqual("Bingo", ct.titular)
        self.assertEqual("0001-5", ct.obter_identificador())
        self.assertEqual(self.ag, ct.agencia)
        # TEARDOWN FIXTURES

    def test_criacao_por_agencia(self):
        # IMPLICIT FIXTURE SETUP
        # EXERCISE SUT
        ct = self.ct
        # RESULT VERIFICATION
        self.assertEqual("Bingo", ct.titular)
        self.assertEqual('0001-5', ct.obter_identificador())
        self.assertEqual(self.ag, ct.agencia)
        # TEARDOWN FIXTURES

    def test_calcular_saldo(self):
        # IMPLICIT/INLINE FIXTURE SETUP
        self.ct.adicionar_transacao(Entrada(Dinheiro(Moeda.BRL, 10, 0)))
        self.ct.adicionar_transacao(Saida(Dinheiro(Moeda.BRL, 5, 0)))
        # EXERCISE SUT
        saldo = self.ct.calcular_saldo()
        # RESULT VERIFICATION
        self.assertEqual(5, saldo.obter_quantia().inteiro)
        # TEARDOWN FIXTURES

