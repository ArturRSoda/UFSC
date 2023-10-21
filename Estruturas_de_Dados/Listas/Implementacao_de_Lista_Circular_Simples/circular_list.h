//! Copyright [2023] <Artur Soda>

#ifndef STRUCTURES_CIRCULAR_LIST_H
#define STRUCTURES_CIRCULAR_LIST_H

#include <cstddef>
#include <cstdint>
#include <stdexcept>

namespace structures {

template<typename T>
class CircularList {
 public:
    CircularList();
    ~CircularList();

    void clear();  // limpar lista

    void push_back(const T& data);  // inserir no fim
    void push_front(const T& data);  // inserir no início
    void insert(const T& data, std::size_t index);  // inserir na posição
    void insert_sorted(const T& data);  // inserir em ordem

    T& at(std::size_t index);  // acessar em um indice (com checagem de limites)
    const T& at(std::size_t index) const;  // versão const do acesso ao indice

    T pop(std::size_t index);  // retirar da posição
    T pop_back();  // retirar do fim
    T pop_front();  // retirar do início
    void remove(const T& data);  // remover dado específico

    bool empty() const;  // lista vazia
    bool contains(const T& data) const;  // lista contém determinado dado?
    std::size_t find(const T& data) const;  // posição de um item na lista

    std::size_t size() const;  // tamanho da lista

 private:
	class Node {
 public:
			Node():
				data_{NULL}
			 {}

			explicit Node(const T& data):
				data_{data}
			 {}

			Node(const T& data, Node* next):
				data_{data},
				next_{next}
			 {}

			 T& data() {
				 return data_;
			 }

			 const T& data() const {
				 return data_;
			 }

			 Node* next() {
				 return next_;
			 }

			 const Node* next() const {
				 return next_;
			 }

			 void next(Node* next) {
				 next_ = next;
			 }

 private:
			T data_;
			Node* next_;
	};

	Node* head;
	std::size_t size_;
};

}  // namespace structures

template<typename T>
structures::CircularList<T>::CircularList() {
	head = new Node();
	head->next(head);
	size_ = 0;
}

template<typename T>
structures::CircularList<T>::~CircularList() {
	this->clear();
	delete head;
}

template<typename T>
void structures::CircularList<T>::clear() {
	while (!this->empty()) {
		this->pop_front();
	}
}

template<typename T>
void structures::CircularList<T>::push_back(const T& data) {
	Node* nw = new Node(data, head);
	if (nw == nullptr) return;

	Node* p = head;
	for (size_t i = 0; i < size_; i++) {
		p = p->next();
	}

	p->next(nw);
	size_++;
}

template<typename T>
void structures::CircularList<T>::push_front(const T& data) {
	Node* nw = new Node(data, head->next());
	if (nw == nullptr) return;

	head->next(nw);
	size_++;
}

template<typename T>
void structures::CircularList<T>::insert(const T& data, std::size_t index) {
	if (index > size_)
		throw std::out_of_range("index fora do range");

	if (index == 0) {
		this->push_front(data);
		return;
	}

	if (index == size_) {
		this->push_back(data);
		return;
	}

	Node* nw = new Node(data);

	Node* p = head;
	for (size_t i = 0; i < index; i++) {
		p = p->next();
	}

	nw->next(p->next());
	p->next(nw);
	size_++;
}

template<typename T>
void structures::CircularList<T>::insert_sorted(const T& data) {
	Node* p = head->next();
	if (size_ != 0) {
		for (size_t i = 0; i < size_; i++) {
			if (p->data() > data) {
				this->insert(data, i);
				return;
			}
			p = p->next();
		}
		this->push_back(data);
	} else {
		this->push_front(data);
	}
}

template<typename T>
T& structures::CircularList<T>::at(std::size_t index) {
	if (this->empty()) throw std::out_of_range("Lista vazia");
	if (index >= size_) throw std::out_of_range("index fora do range");

	Node* p = head->next();
	for (size_t i = 0; i < index; i++) {
		p = p->next();
	}
	return p->data();
}

template<typename T>
const T& structures::CircularList<T>::at(std::size_t index) const {
	if (this->empty()) throw std::out_of_range("Lista vazia");
	if (index >= size_) throw std::out_of_range("index fora do range");

	Node* p = head->next();
	for (size_t i = 0; i < index; i++) {
		p = p->next();
	}
	return p->data();
}

template<typename T>
T structures::CircularList<T>::pop(std::size_t index) {
	if (this->empty()) throw std::out_of_range("lista vazia");
	if (index >= size_) throw std::out_of_range("index fora do range");

	Node* p = head;
	for (size_t i = 0; i < index; i++) {
		p = p->next();
	}

	Node* temp = p->next();
	T aux = temp->data();

	p->next(temp->next());
	delete temp;
	size_--;
	return aux;
}

template<typename T>
T structures::CircularList<T>::pop_back() {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* p;
	if (size_ == 1) {
		p = head;
	} else {
		p = head->next();
		for (size_t i = 0; i < size_-2; i++) {
			p = p->next();
		}
	}

	Node* temp = p->next();
	T aux = temp->data();

	p->next(temp->next());
	delete temp;
	size_--;
	return aux;
}

template<typename T>
T structures::CircularList<T>::pop_front() {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* temp = head->next();
	T aux = temp->data();

	head->next(temp->next());
	delete temp;
	size_--;
	return aux;
}


template<typename T>
void structures::CircularList<T>::remove(const T& data) {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* p = head;
	while (p->next()->data() != data) {
		p = p->next();
	}

	Node* temp = p->next();

	p->next(temp->next());
	delete temp;
	size_--;
}

template<typename T>
bool structures::CircularList<T>::empty() const {
	return (size_ == 0);
}

template<typename T>
bool structures::CircularList<T>::contains(const T& data) const {
	if (this->empty()) throw std::out_of_range("lista vazia");

	Node* p = head->next();
	for (size_t i = 0; i < size_; i++) {
		if (p->data() == data) return true;
		p = p->next();
	}
	return false;
}

template<typename T>
std::size_t structures::CircularList<T>::find(const T& data) const {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* p = head->next();
	for (size_t i = 0; i < size_; i++) {
		if (p->data() == data) return i;
		p = p->next();
	}
	return size_;
}

template<typename T>
std::size_t structures::CircularList<T>::size() const {
	return size_;
}

#endif


