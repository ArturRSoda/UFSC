import unittest

from agencia import Agencia
from conta import Conta
from banco import Banco
from dinheiro import Moeda

def return_delagated_setup():
    b = Banco("Banco_Bango", Moeda.BRL)
    return b.criar_agencia("Agencia_Bungo")

class TesteAgencia(unittest.TestCase):

    def test_criacao_por_construtor(self):
        # INLINE FIXTURE SETUP
        b = Banco("Banco_Bango", Moeda.BRL)
        # EXERCISE SUT
        ag = Agencia("Agencia_Bungo", 0, b)
        # RESULT VERIFICATION
        self.assertEqual("Agencia_Bungo", ag.nome)
        self.assertEqual('000', ag.obter_identificador())
        self.assertEqual(b, ag.banco)
        # TEARDOWN FIXTURES

    def test_criacao_pelo_banco(self):
        # INLINE FIXTURE SETUP
        b = Banco("Banco_Bango", Moeda.BRL)
        # EXERCISE SUT
        ag = b.criar_agencia("Agencia_Bungo")
        # RESULT VERIFICATION
        self.assertEqual("Agencia_Bungo", ag.nome)
        self.assertEqual('001', ag.obter_identificador())
        self.assertEqual(b, ag.banco)
        # TEARDOWN FIXTURES

    def test_criar_conta(self):
        # DELEGATED FIXTURE SETUP
        ag = return_delagated_setup()
        # EXERCISE SUT
        ag.criar_conta("Bingo")
        # RESULT VERIFICATION
        self.assertEqual(1, len(ag.obter_contas()))
        # TEARDOWN FIXTURES

    def test_verificar_obter_conta(self):
        # DELEGATED/INLINE FIXTURE SETUP
        ag = return_delagated_setup()
        ag.criar_conta("Bingo")
        # EXERCISE SUT
        ct = ag.obter_conta('0001-5')
        # RESULT VERIFICATION
        self.assertTrue(ct != None)
        # TEARDOWN FIXTURES


