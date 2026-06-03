# Teste C: Duas operações diferentes, uma sendo subtração
# Operação: 75 - 25 = 50, depois 50 × 3 = 150

import unittest
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.options import Options


class TestSubtracaoEMultiplicacao(unittest.TestCase):

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

    def test_subtracao_e_multiplicacao(self):
        # Primeira operação: subtração 75 - 25
        self.clicar("7")
        self.clicar("5")
        self.clicar("-")
        self.clicar("2")
        self.clicar("5")
        self.clicar("=")
        time.sleep(1)

        # Segunda operação: multiplica o resultado anterior (50) por 3
        self.clicar("×")
        self.clicar("3")
        self.clicar("=")
        time.sleep(1)

        resultado_final = self.ler_resultado()
        self.assertEqual(resultado_final, "150",
                         f"50 × 3 deveria ser 150, obtido '{resultado_final}'")


if __name__ == "__main__":
    unittest.main()
