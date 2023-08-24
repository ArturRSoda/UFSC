// Copyright [2022] <Artur Soda>
#include "./array_stack.h"
#include <stdexcept>

bool verificaChaves(std::string trecho_programa) {
    bool resposta = true;
    int  tamanho  = trecho_programa.length();
    structures::ArrayStack<char> pilha(500);
	char caracter;
    
    for (int i = 0; i < tamanho; i++) {
        // condições de parada dor 'for' podem ser adicionadas...

		caracter = trecho_programa[i];
		if (caracter == '{') {
			pilha.push(caracter);
		}
		else if (caracter == '}') {
			if (pilha.empty()) throw; 
			else pilha.pop();
		}
    }

	if (!(pilha.empty())) resposta = false;
	else resposta = true;
		
		
    
    return resposta;
}
