// Copyright [2022] <Artur Soda>
#include <string>
#include "./array_queue.h"

structures::ArrayQueue<char> editaTexto(std::string texto) {
    structures::ArrayQueue<char> fila(500);

	int tam = texto.size();

	for (int i = 0; i < tam; i++) {
		if (texto[i] == '<') {
			fila.dequeue();
		} else if (texto[i] == '>') {
			fila.enqueue(fila.back());
		} else {
			fila.enqueue(texto[i]);
		}
	}

    return fila;
}


