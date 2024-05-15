# ----- Variaveis -----
	# Target
TARGET = result
	# Compilador
CC = clisp
	# Diretorio fonte
SRC = Src
# ---------------------


# ----- Compilacao -----
# Compila
$(TARGET): $(SRC)/main.lisp
	$(CC) -c $(SRC)/main.lisp -o $(TARGET)
# ----------------------

clean:
	rm $(TARGET).*

.PHONY: clean
