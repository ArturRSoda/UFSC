# Teste D: Três operações diferentes, verificar cada resultado e o histórico
# Operações: 11 + 22 = 33, 99 - 44 = 55, 6 × 7 = 42

import unittest
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.options import Options


class TestTresOperacoesEHistorico(unittest.TestCase):

    def setUp(self):
        # Inicia o Firefox
        service = Service(executable_path="/snap/bin/geckodriver")
        options = Options()
        options.binary_location = "/snap/firefox/current/usr/lib/firefox/firefox"
        self.driver = webdriver.Firefox(service=service, options=options)
        self.driver.maximize_window()
        self.wait = WebDriverWait(self.driver, 15)

        # Abre o DuckDuckGo já na busca da calculadora
        self.driver.get("https://duckduckgo.com/?q=calculator")
        # Aguarda o botão '5' ficar disponível
        self.wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, "button[value='5']")))
        time.sleep(0.5)

    def tearDown(self):
        # Aguarda um momento para visualização e fecha o navegador
        time.sleep(3)
        self.driver.quit()

    def clicar(self, valor):
        # Seleciona o botão pelo atributo value e clica
        botao = self.wait.until(EC.element_to_be_clickable(
            (By.CSS_SELECTOR, f"button[value='{valor}']")
        ))
        botao.click()
        time.sleep(0.2)

    def ler_resultado(self):
        # Lê o resultado do visor principal (#display)
        return self.driver.find_element(By.CSS_SELECTOR, "#display").text.strip()

    def limpar(self):
        # Pressiona C para limpar o display e iniciar nova operação
        self.driver.find_element(By.CSS_SELECTOR, "button[value='C']").click()
        time.sleep(0.3)

    def test_tres_operacoes_e_historico(self):
        # Operação 1: 11 + 22 = 33
        self.clicar("1")
        self.clicar("1")
        self.clicar("+")
        self.clicar("2")
        self.clicar("2")
        self.clicar("=")
        time.sleep(1)

        resultado_1 = self.ler_resultado()

        # Limpa para a próxima operação
        self.limpar()

        # Operação 2: 99 - 44 = 55
        self.clicar("9")
        self.clicar("9")
        self.clicar("-")
        self.clicar("4")
        self.clicar("4")
        self.clicar("=")
        time.sleep(1)

        resultado_2 = self.ler_resultado()

        # Limpa para a próxima operação
        self.limpar()

        # Operação 3: 6 × 7 = 42
        self.clicar("6")
        self.clicar("×")
        self.clicar("7")
        self.clicar("=")
        time.sleep(1)

        resultado_3 = self.ler_resultado()

        # Lê todos os resultados listados no histórico
        elementos_resultado = self.driver.find_elements(By.CSS_SELECTOR, ".tile__past-result")
        resultados_historico = [e.text.strip() for e in elementos_resultado]

        # Verifica os resultados individuais
        self.assertEqual(resultado_1, "33")
        self.assertEqual(resultado_2, "55")
        self.assertEqual(resultado_3, "42")

        # Verifica que as três operações aparecem no histórico
        self.assertIn("33", resultados_historico)
        self.assertIn("55", resultados_historico)
        self.assertIn("42", resultados_historico)


if __name__ == "__main__":
    unittest.main()
