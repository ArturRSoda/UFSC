import unittest
import datetime

class TestDatetime(unittest.TestCase):

	def test_cria_data_valida(self):
		# Fixture Setup
		# Exerise SUT
		data = datetime.date(2026,3,17)
		# Result Verification
		self.assertEqual(2026, data.year)
		self.assertEqual(3, data.month)
		self.assertEqual(17, data.day)
		# Fixture Teardown

	def test_cria_ano_negativo(self):
		# Fixture Setup
		# Exerise SUT
		with self.assertRaises(ValueError):
			data = datetime.date(-2026,3,17)
		# Result Verification
		# Fixture Teardown

	def test_cria_mes_negativo(self):
		# Fixture Setup
		# Exerise SUT
		with self.assertRaises(ValueError):
			data = datetime.date(2026,-3,17)
		# Result Verification
		# Fixture Teardown

	def test_cria_dia_negativo(self):
		# Fixture Setup
		# Exerise SUT
		with self.assertRaises(ValueError):
			data = datetime.date(2026,3,-17)
		# Result Verification
		# Fixture Teardown

	def test_cria_dia_maior_que_31(self):
		# Fixture Setup
		# Exerise SUT
		with self.assertRaises(ValueError):
			data = datetime.date(2026,3,32)
		# Result Verification
		# Fixture Teardown

	def test_cria_mes_maior_que_12(self):
		# Fixture Setup
		# Exerise SUT
		with self.assertRaises(ValueError):
			data = datetime.date(2026,13,17)
		# Result Verification
		# Fixture Teardown

	def test_cria_ano_bissexto_valido(self):
		# Fixture Setup
		# Exerise SUT
		data = datetime.date(2024,2,29)
		# Result Verification
		self.assertEqual(29, data.day)
		self.assertEqual(2, data.month)
		# Fixture Teardown

	def test_cria_ano_bissexto_invalido(self):
		# Fixture Setup
		# Exerise SUT
		with self.assertRaises(ValueError):
			data = datetime.date(2026,2,29)
		# Result Verification
		# Fixture Teardown

	def test_cria_time_valido(self):
		# Fixture Setup
		# Exerise SUT
		time = datetime.time(12, 14, 36)
		# Result Verification
		self.assertEqual(12, time.hour)
		self.assertEqual(14, time.minute)
		self.assertEqual(36, time.second)
		# Fixture Teardown

	def test_cria_time_hora_negativa(self):
		# Fixture Setup
		# Exerise SUT
		with self.assertRaises(ValueError):
			time = datetime.time(hour = -1)
		# Result Verification
		# Fixture Teardown

	def test_cria_time_minuto_negativa(self):
		# Fixture Setup
		# Exerise SUT
		with self.assertRaises(ValueError):
			time = datetime.time(minute = -1)
		# Result Verification
		# Fixture Teardown

	def test_cria_time_segundo_negativa(self):
		# Fixture Setup
		# Exerise SUT
		with self.assertRaises(ValueError):
			time = datetime.time(second = -1)
		# Result Verification
		# Fixture Teardown

	def test_timedelta_valido(self):
		# Fixture Setup
		data1 = datetime.datetime(2023, 10, 1)
		data2 = datetime.datetime(2023, 10, 10)
		# Exerise SUT
		diferenca = data2 - data1 
		# Result Verification
		self.assertEqual(datetime.timedelta(days=9), diferenca)
		# Fixture Teardown

	def test_timedelta_negativo(self):
		# Fixture Setup
		data1 = datetime.datetime(2023, 10, 10)
		data2 = datetime.datetime(2023, 10, 1)
		# Exerise SUT
		diferenca = data2 - data1 
		# Result Verification
		self.assertEqual(datetime.timedelta(days=-9), diferenca)
		# Fixture Teardown

	def test_data_ano_zero(self):
		# Fixture Setup
		# Exerise SUT
		with self.assertRaises(ValueError):
			data = datetime.datetime(0, 10, 10)
		# Result Verification
		# Fixture Teardown

	def test_replace_ano_valido(self):
		# Fixture Setup
		data = datetime.date(2026, 1, 1)
		# Exerise SUT
		data = data.replace(year=2025)
		# Result Verification
		self.assertEqual(2025, data.year)
		# Fixture Teardown

	def test_replace_ano_invalido_negativo(self):
		# Fixture Setup
		data = datetime.date(2026, 1, 1)
		# Exerise SUT
		with self.assertRaises(ValueError):
			data = data.replace(year=-2025)
		# Result Verification
		# Fixture Teardown

	def test_timedelta_ano_zero(self):
		# Fixture Setup
		# Exerise SUT
		with self.assertRaises(ValueError):
			data = datetime.datetime(0, 10, 10)
		# Result Verification
		# Fixture Teardown

	def test_verificar_se_um_minuto_tem_60_segundos(self):
		# Fixture Setup
		# Exerise SUT
		timedelta = datetime.timedelta(minutes=1)
		# Result Verification
		self.assertEqual(60, timedelta.seconds)
		# Fixture Teardown

	def test_verificar_se_soma_troca_mes(self):
		# Fixture Setup
		data = datetime.datetime(2026, 1, 10)
		# Exerise SUT
		data += datetime.timedelta(days=30)
		# Result Verification
		self.assertEqual(2, data.month)
		# Fixture Teardown

	def test_verificar_se_soma_troca_ano(self):
		# Fixture Setup
		data = datetime.datetime(2026, 1, 1)
		# Exerise SUT
		data += datetime.timedelta(days=365)
		# Result Verification
		self.assertEqual(2027, data.year)
		# Fixture Teardown

	def test_operacao_menor_que_verdadeiro(self):
		# Fixture Setup
		data1 = datetime.datetime(2026, 1, 1)
		data2 = datetime.datetime(2026, 1, 2)
		# Exerise SUT
		comparacao = data1 < data2
		# Result Verification
		self.assertEqual(True, comparacao)
		# Fixture Teardown

	def test_operacao_maior_que_falso(self):
		# Fixture Setup
		data1 = datetime.datetime(2026, 1, 1)
		data2 = datetime.datetime(2026, 1, 2)
		# Exerise SUT
		comparacao = data1 > data2
		# Result Verification
		self.assertEqual(False, comparacao)
		# Fixture Teardown

	def test_comparacao_timedeltas_com_criacoes_diferentes(self):
		# Fixture Setup
		timedelta1 = datetime.timedelta(days=1)
		timedelta2 = datetime.timedelta(hours=24)
		# Exerise SUT
		comparacao = timedelta1 == timedelta2 
		# Result Verification
		self.assertEqual(True, comparacao)
		# Fixture Teardown

	def test_data_isoformat_valido(self):
		# Fixture Setup
		data = datetime.date(2026, 1, 1)
		# Exerise SUT
		isoformat = data.isoformat()
		# Result Verification
		self.assertEqual('2026-01-01', isoformat)
		# Fixture Teardown
	


if __name__ == '__main__':
	unittest.main()
