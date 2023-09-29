//! Copyright [2023] <Artur Soda>

#ifndef STRUCTURES_CIRCULAR_LIST_H
#define STRUCTURES_CIRCULAR_LIST_H

#include <cstdint>
#include <cstdio>
#include <stdexcept>

namespace structures {

template<typename T>
class DoublyCircularList {
 public:
    DoublyCircularList();
    ~DoublyCircularList();

    void clear();

    void push_back(const T& data);  // insere no fim
    void push_front(const T& data);  // insere no início
    void insert(const T& data, std::size_t index);  // insere na posição
    void insert_sorted(const T& data);  // insere em ordem

    T pop(std::size_t index);  // retira da posição
    T pop_back();  // retira do fim
    T pop_front();  // retira do início
    void remove(const T& data);  // retira específico

    bool empty() const;  // lista vazia
    bool contains(const T& data) const;  // contém

    T& at(std::size_t index);  // acesso a um elemento (checando limites)
    const T& at(std::size_t index) const;  // getter constante a um elemento

    std::size_t find(const T& data) const;  // posição de um dado
    std::size_t size() const;  // tamanho

 private:
    class Node {
     public:
        explicit Node(const T& data):
			data_{data}
		 {}

        Node(const T& data, Node* next):
			data_{data},
			next_{next}
		 {}

        Node(const T& data, Node* prev, Node* next):
			data_{data},
			prev_{prev},
			next_{next}
		 {}

        T& data() {
			return data_;
		}

        const T& data() const {
			return data_;
		}

        Node* prev() {
			return prev_;
		}

        const Node* prev() const {
			return prev_;
		}

        void prev(Node* node) {
			prev_ = node;
		}

        Node* next() {
			return next_;
		}

        const Node* next() const {
			return next_;
		}

        void next(Node* node) {
			next_ = node;
		}

     private:
        T data_;
        Node* prev_;
        Node* next_;
    };

    Node* head;
    std::size_t size_;
};

}  // namespace structures

template<typename T>
structures::DoublyCircularList<T>::DoublyCircularList() {
	head = new Node(0);
	head->next(head);
	head->prev(head);
	size_ = 0;
}

template<typename T>
structures::DoublyCircularList<T>::~DoublyCircularList() {
	this->clear();
	delete head;
}

template<typename T>
void structures::DoublyCircularList<T>::clear() {
	while (!this->empty()) {
		this->pop_front();
	}
}

template<typename T>
void structures::DoublyCircularList<T>::push_back(const T& data) {
	Node* nw = new Node(data, head->prev(), head);
	if (nw == nullptr) return;

	head->prev()->next(nw);
	head->prev(nw);
	size_++;
}

template<typename T>
void structures::DoublyCircularList<T>::push_front(const T& data) {
	Node* nw = new Node(data, head, head->next());
	if (nw == nullptr) return;

	head->next()->prev(nw);
	head->next(nw);
	size_++;
}

template<typename T>
void structures::DoublyCircularList<T>::insert(const T& data, std::size_t index) {
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

	Node* p = head;
	for (size_t i = 0; i < index; i++) {
		p = p->next();
	}

	Node* nw = new Node(data, p, p->next());
	p->next()->prev(nw);
	p->next(nw);
	size_++;
}

template<typename T>
void structures::DoublyCircularList<T>::insert_sorted(const T& data) {
	Node* nw = new Node(data);

	if (this->empty()) {
		this->push_front(data);

	} else {
		Node* p = head->next();
		for (size_t i = 0; i < size_; i++) {
			if (p->data() > data) {
				this->insert(data, i);
				return;
			}
			p = p->next();
		}
		this->push_back(data);
	}
}

template<typename T>
T structures::DoublyCircularList<T>::pop(std::size_t index){
	if (this->empty()) throw std::out_of_range("lista vazia");
	if (index >= size_) throw std::out_of_range("index fora do range");

	Node* p = head;
	for (size_t i = 0; i < index; i++) {
		p = p->next();
	}

	Node* temp = p->next();
	T aux = temp->data();

	temp->next()->prev(p);
	p->next(temp->next());

	delete temp;
	size_--;
	return aux;
}

template<typename T>
T structures::DoublyCircularList<T>::pop_back() {
	if (this->empty()) throw std::out_of_range("lista vazia");

	Node* temp = head->prev();
	T aux = temp->data();

	temp->prev()->next(head);
	head->prev(temp->prev());

	delete temp;
	size_--;
	return aux;
}

template<typename T>
T structures::DoublyCircularList<T>::pop_front() {
	if (this->empty()) throw std::out_of_range("lista vazia");

	Node* temp = head->next();
	T aux = temp->data();

	temp->next()->prev(head);
	head->next(temp->next());

	delete temp;
	size_--;
	return aux;
}

template<typename T>
void structures::DoublyCircularList<T>::remove(const T& data) {
	if (this->empty()) throw std::out_of_range("lista vazia");

	Node* p = head->next();
	for (size_t i = 0; i < size_; i++) {
		if (p->next()->data() == data) break;
		p = p->next();
	}

	Node* temp = p->next();

	temp->next()->prev(p);
	p->next(temp->next());

	delete temp;
	size_--;
}

template<typename T>
bool structures::DoublyCircularList<T>::empty() const {
	return (size_ == 0);
}

template<typename T>
bool structures::DoublyCircularList<T>::contains(const T& data) const {
	if (this->empty()) throw std::out_of_range("lista vazia");

	Node* p = head->next();
	for (size_t i = 0; i < size_; i++) {
		if (p->data() == data) return true;
		p = p->next();
	}
	return false;

}

template<typename T>
T& structures::DoublyCircularList<T>::at(std::size_t index) {
	if (this->empty()) throw std::out_of_range("lista vazia");
	if (index >= size_) throw std::out_of_range("index fora de range");

	Node* p = head->next();
	for (size_t i = 0; i < index; i++) {
		p = p->next();
	}
	return p->data();
}

template<typename T>
const T& structures::DoublyCircularList<T>::at(std::size_t index) const {
	if (this->empty()) throw std::out_of_range("lista vazia");
	if (index >= size_) throw std::out_of_range("index fora de range");

	Node* p = head->next();
	for (size_t i = 0; i < index; i++) {
		p = p->next();
	}
	return p->data();
}

template<typename T>
std::size_t structures::DoublyCircularList<T>::find(const T& data) const {
	if (this->empty()) throw std::out_of_range("lista vazia");

	Node* p = head->next();
	for (size_t i = 0; i < size_; i++) {
		if (p->data() == data) return i;
		p = p->next();
	}
	return size_;
}

template<typename T>
std::size_t structures::DoublyCircularList<T>::size() const {
	return size_;
}

#endif

