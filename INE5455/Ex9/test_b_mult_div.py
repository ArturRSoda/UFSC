# Teste B: Multiplicar dois números e dividir o resultado por 10
# Operação: 8 × 15 = 120, depois 120 ÷ 10 = 12

import unittest
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.options import Options


class TestMultiplicacaoDivisao(unittest.TestCase):

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

    def test_multiplicacao_e_divisao(self):
        # Primeira parte: 8 × 15
        self.clicar("8")
        self.clicar("×")
        self.clicar("1")
        self.clicar("5")
        self.clicar("=")
        time.sleep(1)

        # Segunda parte: divide o resultado anterior (120) por 10
        self.clicar("÷")
        self.clicar("1")
        self.clicar("0")
        self.clicar("=")
        time.sleep(1)

        # Verifica o resultado final da divisão
        resultado_final = self.ler_resultado()
        self.assertEqual(resultado_final, "12",
                         f"120 ÷ 10 deveria ser 12, obtido '{resultado_final}'")


if __name__ == "__main__":
    unittest.main()
