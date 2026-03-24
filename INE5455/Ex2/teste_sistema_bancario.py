import unittest

from dinheiro import Moeda, Dinheiro, ValorMonetario
from banco import Banco
from conta import Conta
from operacao import EstadosDeOperacao, Operacao
from transacao import TransacaoNaoRealizada, Entrada, Saida
from sistema_bancario import SistemaBancario


class TesteSistemaBancario(unittest.TestCase):

    def setUp(self):
        self.sb = SistemaBancario()
        self.bc = self.sb.criar_banco("Banco_Bango", Moeda.BRL)
        self.ag = self.sb.obter_banco("Banco_Bango").criar_agencia("Agencia_Balango")
        self.saramango = self.sb.obter_banco("Banco_Bango").obter_agencia("Agencia_Balango").criar_conta("Saramango")
        self.tango = self.sb.obter_banco("Banco_Bango").obter_agencia("Agencia_Balango").criar_conta("Tango")

    def test_depositar(self):
        # IMPLICIT FIXTURE SETUP
        # EXERCISE SUT
        self.sb.depositar(self.saramango, Dinheiro(Moeda.BRL, 100, 0))
        # RESULT VERIFICATION
        self.assertEqual(10000, self.saramango.calcular_saldo().obter_quantia().obter_quantia_em_escala())
        # TEARDOWN FIXTURES

    def test_sacar(self):
        # IMPLICIT/INLINE FIXTURE SETUP
        self.sb.depositar(self.saramango, Dinheiro(Moeda.BRL, 100, 0))
        # EXERCISE SUT
        self.sb.sacar(self.saramango, Dinheiro(Moeda.BRL, 50, 0))
        # RESULT VERIFICATION
        self.assertEqual(5000, self.saramango.calcular_saldo().obter_quantia().obter_quantia_em_escala())
        # TEARDOWN FIXTURES

    def test_saldo_ficara_negativo(self):
        # IMPLICIT FIXTURE SETUP
        # EXERCISE SUT
        b = self.sb.saldo_ficara_negativo(self.tango.calcular_saldo(), Dinheiro(Moeda.BRL, 10, 0))
        # RESULT VERIFICATION
        self.assertTrue(b)
        # TEARDOWN FIXTURES

    def test_transferir(self):
        # IMPLICIT/INLINE FIXTURE SETUP
        self.sb.depositar(self.saramango, Dinheiro(Moeda.BRL, 100, 0))
        # EXERCISE SUT
        self.sb.transferir(self.saramango, self.tango, Dinheiro(Moeda.BRL, 50, 0))
        # RESULT VERIFICATION
        self.assertEqual(5000, self.saramango.calcular_saldo().obter_quantia().obter_quantia_em_escala())
        self.assertEqual(5000, self.tango.calcular_saldo().obter_quantia().obter_quantia_em_escala())
        # TEARDOWN FIXTURES





