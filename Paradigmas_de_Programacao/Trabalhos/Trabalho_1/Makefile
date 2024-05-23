# ----- Variaveis -----
	# Target
TARGET = result
	# Compilador
CC = ghc
	# Diretorio fonte
SRC = Src
	# Pasta dos arquivos objetos
OBJ_DIR = Obj
# ---------------------


# ----- Compilacao -----
# Compila
$(TARGET): $(SRC)/*.hs
	$(CC) -o $(TARGET) $(SRC)/*.hs -outputdir ./$(OBJ_DIR) 
# ----------------------


clean:
	rm -rf $(OBJ_DIR) $(TARGET)

# Cria o diretorio dos .o files
$(shell mkdir -p $(OBJ_DIR))

.PHONY: clean
