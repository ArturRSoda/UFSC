// Copyright [2022] <Artur Soda>
#include <string>
#include "./array_stack.h"
#include <stdexcept>

int find_i(char x, std::string s) {
	int tam = s.size();
	for (int i = 0; i < tam; i++) {
		if (x == s[i])
			return i;
	}
}

bool verificaChaves(std::string trecho_programa) {
    bool resposta = true;
    int  tamanho  = trecho_programa.length();
    structures::ArrayStack<char> pilha(500);
	char caracter;
	std::string abriu = "({[";
	std::string fechou = ")}]";

    
    for (int i = 0; i < tamanho; i++) {
        // condições de parada dor 'for' podem ser adicionadas...

		caracter = trecho_programa[i];
		if (abriu.find(caracter)) {
			pilha.push(caracter);
		}
		else if (fechou.find(caracter)) {
			
			if (caracter == fechou[find_i(pilha.top(), abriu)]) {
				if (pilha.empty()) return false; 
				else pilha.pop();
			}
			else return false;
		}
    }

	if (!(pilha.empty())) resposta = false;
	else resposta = true;
		
		
    
    return resposta;
}
