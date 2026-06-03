# Script para encontrar o seletor CSS do display da calculadora
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.options import Options
import time

service = Service(executable_path="/snap/bin/geckodriver")
options = Options()
options.binary_location = "/snap/firefox/current/usr/lib/firefox/firefox"
driver = webdriver.Firefox(service=service, options=options)
driver.maximize_window()

try:
    driver.get("https://duckduckgo.com/?q=calculator")
    wait = WebDriverWait(driver, 15)
    wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, "button[value='5']")))
    time.sleep(0.5)

    # Faz um cálculo para ter resultado no display
    for v in ["1", "+", "1", "="]:
        driver.find_element(By.CSS_SELECTOR, f"button[value='{v}']").click()
        time.sleep(0.2)
    time.sleep(0.5)

    print("=== FILHOS DIRETOS DE .tile__calc ===")
    tile = driver.find_element(By.CSS_SELECTOR, ".tile__calc")
    for filho in tile.find_elements(By.XPATH, "./*"):
        cls = filho.get_attribute("class") or ""
        txt = filho.text.strip()[:60].replace("\n", " | ")
        print(f"  <{filho.tag_name}> class='{cls}' | texto='{txt}'")

    print("\n=== TODOS OS ELEMENTOS DENTRO DE .tile__calc ===")
    for e in tile.find_elements(By.XPATH, ".//*"):
        cls = e.get_attribute("class") or ""
        txt = e.text.strip()
        if txt and len(txt) < 80 and "button" not in cls:
            print(f"  <{e.tag_name}> class='{cls}' | texto='{txt[:60]}'")

    print("\n=== innerHTML do display (primeiros 2000 chars) ===")
    html = driver.execute_script("return document.querySelector('.tile__calc').innerHTML;")
    print(html[:2000])

finally:
    time.sleep(2)
    driver.quit()
