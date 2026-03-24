import unittest

from banco import Banco
from dinheiro import Moeda

class TesteBanco(unittest.TestCase):

    def setUp(self):
        self.banco = Banco("Banco_Bango", Moeda.BRL)

    def test_criacao_banco(self):
        # IMPLICIT FIXTURE SETUP
        # EXERCISE SUT
        banco = self.banco
        # RESULT VERIFICATION
        self.assertEqual("Banco_Bango", banco.nome)
        self.assertEqual(Moeda.BRL, banco.moeda)
        # TEARDOWN FIXTURES

    def test_obter_agencias(self):
        # IMPLICIT FIXTURE SETUP
        # EXERCISE SUT
        agencias = self.banco.obter_agencias()
        # RESULT VERIFICATION
        self.assertEqual(0, len(agencias))
        self.assertEqual([], agencias)
        # TEARDOWN FIXTURES

    def test_criar_agencias(self):
        # IMPLICIT FIXTURE SETUP
        # EXERCISE SUT
        self.banco.criar_agencia("Agencia_Bungo")
        # RESULT VERIFICATION
        self.assertEqual(1, len(self.banco.obter_agencias()))
        # TEARDOWN FIXTURES

    def test_obter_agencia(self):
        # IMPLICIT/INLINE FIXTURE SETUP
        self.banco.criar_agencia("Agencia_Bungo")
        # EXERCISE SUT
        ag = self.banco.obter_agencia("Agencia_Bungo")
        # RESULT VERIFICATION
        self.assertTrue(ag != None)
        # TEARDOWN FIXTURES




