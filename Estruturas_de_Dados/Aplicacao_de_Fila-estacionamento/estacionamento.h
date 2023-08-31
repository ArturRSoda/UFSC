// Copyright [2023] <Artur Soda>

/*
    *** Importante ***

    O código de fila em vetor está disponível internamente (não precisa de implementação aqui)

*/



void retira_veiculo(structures::ArrayQueue<int> *f, int k) {

	for (int i = 0; i < --k; i++) {
		f->enqueue(f->dequeue());
	}
	f->dequeue();
}


void mantenha_veiculo(structures::ArrayQueue<int> *f, int k) {
	int t = static_cast<int>(f->size());
	k--;
	for (int i = 0; i < f->size(); i++) {
		if (i == k)
			f->enqueue(f->dequeue());
		else
			f->dequeue();
	}
}



/*
    *** Importante ***

    A função 'main()' não deve ser escrita aqui, pois é parte do código dos testes e já está implementada

*/

