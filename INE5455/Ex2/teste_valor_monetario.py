import unittest

from dinheiro import Dinheiro, ValorMonetario, Moeda

def return_delegated_setup():
    return ValorMonetario(Moeda.BRL, 1000)

class TesteValorMonetario(unittest.TestCase):

    def test_criacao_valor_monetario_negativo(self):
        # INLINE FIXTURE SETUP
        vm = ValorMonetario(Moeda.BRL, -1000)
        # EXERCISE SUT
        r = vm.negativo()
        # RESULT VERIFICATION
        self.assertTrue(r)
        # TEARDOWN FIXTURES

    def test_validacao_moeda(self):
        # DELEGATED FIXTURE SETUP
        vm = return_delegated_setup()
        # EXERCISE SUT
        vm.validar_moeda(Dinheiro(Moeda.BRL, 0, 0))
        # RESULT VERIFICATION
        # TEARDOWN FIXTURES

    def test_operacao_somar(self):
        # DELEGATED FIXTURE SETUP
        vm = return_delegated_setup()
        # EXERCISE SUT
        r = vm.somar(Dinheiro(Moeda.BRL, 5, 0))
        # RESULT VERIFICATION
        self.assertEqual(15, r.obter_quantia().inteiro)
        # TEARDOWN FIXTURES

    def test_operacao_subtrair(self):
        # DELEGATED FIXTURE SETUP
        vm = return_delegated_setup()
        # EXERCISE SUT
        r = vm.subtrair(Dinheiro(Moeda.BRL, 5, 0))
        # RESULT VERIFICATION
        self.assertEqual(5, r.obter_quantia().inteiro)
        # TEARDOWN FIXTURES
