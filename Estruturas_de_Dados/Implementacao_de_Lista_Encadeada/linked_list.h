//! Copyright [year] <Copyright Owner>
#ifndef STRUCTURES_LINKED_LIST_H
#define STRUCTURES_LINKED_LIST_H

#include <cstdint>
#include <stdexcept>


namespace structures {

//! ...
template<typename T>
class LinkedList {
 public:
    //! ...
    LinkedList();  // construtor padrão
    //! ...
    ~LinkedList();  // destrutor
    //! ...
    void clear();  // limpar lista
    //! ...
    void push_back(const T& data);  // inserir no fim
    //! ...
    void push_front(const T& data);  // inserir no início
    //! ...
    void insert(const T& data, std::size_t index);  // inserir na posição
    //! ...
    void insert_sorted(const T& data);  // inserir em ordem
    //! ...
    T& at(std::size_t index);  // acessar um elemento na posição index
    //! ...
    T pop(std::size_t index);  // retirar da posição
    //! ...
    T pop_back();  // retirar do fim
    //! ...
    T pop_front();  // retirar do início
    //! ...
    void remove(const T& data);  // remover específico
    //! ...
    bool empty() const;  // lista vazia
    //! ...
    bool contains(const T& data) const;  // contém
    //! ...
    std::size_t find(const T& data) const;  // posição do dado
    //! ...
    std::size_t size() const;  // tamanho da lista

 private:
    class Node {  // Elemento
     public:
        explicit Node(const T& data):
            data_{data}
        {}

        Node(const T& data, Node* next):
            data_{data},
            next_{next}
        {}

        T& data() {  // getter: dado
            return data_;
        }

        const T& data() const {  // getter const: dado
            return data_;
        }

        Node* next() {  // getter: próximo
            return next_;
        }

        const Node* next() const {  // getter const: próximo
            return next_;
        }

        void next(Node* node) {  // setter: próximo
            next_ = node;
        }

     private:
        T data_;
        Node* next_{nullptr};
    };

    Node* end() {  // último nodo da lista
        auto it = head;
        for (auto i = 1u; i < size(); ++i) {
            it = it->next();
        }
        return it;
    }

    Node* head{nullptr};
    std::size_t size_{0u};
};

}  // namespace structures

template<typename T>
structures::LinkedList<T>::LinkedList() {
	size_ = 0;
	head = nullptr;
}

template<typename T>
structures::LinkedList<T>::~LinkedList() {
	this->clear();
}

template<typename T>
void structures::LinkedList<T>::clear() {
	while (!(this->empty())) {
		this->pop_front();
	}
}

template<typename T>
void structures::LinkedList<T>::push_back(const T& data) {
	if (this->empty()) {
		this->push_front(data);
		return;
	}

	Node* p;
	p = head;

	Node* novo = new Node(data, nullptr);
	if (novo == nullptr) return;

	while (p->next() != nullptr) {
		p = p->next();
	}
	p->next(novo);
	size_++;
}

template<typename T>
void structures::LinkedList<T>::push_front(const T& data) {
	Node* novo = new Node(data, head);
	if (novo == nullptr) return;
	head = novo;
	size_++;
}

template<typename T>
void structures::LinkedList<T>::insert(const T& data, std::size_t index) {
	if ((static_cast<int>(index) < 0) || (index > size_))
		throw std::out_of_range("Index fora do range");

	if (index == 0) {
		this->push_front(data);
		return;
	}
	if (index == size_) {
		this->push_back(data);
		return;
	}
	Node* p = head;
	for (size_t i = 0; i < index-1; i++) {
		p = p->next();
	}

	Node* novo = new Node(data);
	if (novo == nullptr) return;
	novo->next(p->next());

	p->next(novo);
	size_++;
}

template<typename T>
void structures::LinkedList<T>::insert_sorted(const T& data) {
	Node* p = head;
	size_t i = 0;
	if (static_cast<int>(size_) > 0) {
		if (static_cast<int>(size_) == 1) {
			if (p->data() > data) this->push_front(data);
			else this->push_back(data);
			return;
		}
		while (p->next() != nullptr) {
			if (p->data() > data) {
				this->insert(data, i);
				return;
			}
			i++;
			p = p->next();
		}
		this->push_back(data);

	} else {
		this->push_front(data);
	}
}

template<typename T>
T& structures::LinkedList<T>::at(std::size_t index) {
	if (this->empty()) throw std::out_of_range("Lista vazia");
	if (index >= size_) throw std::out_of_range("index fora do range");
			

	Node* p = head;
	for (size_t i = 0; i < index; i++) {
		p = p->next();
	}

	return p->data();
}

template<typename T>
T structures::LinkedList<T>::pop(std::size_t index) {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	if ((static_cast<int>(index) < 0) || (index >= size_))
		throw std::out_of_range("index fora do range");


	Node* p = head;
	for (size_t i = 0; i < (index-1); i++) {
		p = p->next();
	}

	Node* dado = p->next();
	p->next(dado->next());

	T aux = dado->data();
	delete [] dado;

	size_--;
	return aux;
}

template<typename T>
T structures::LinkedList<T>::pop_back() {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	if (static_cast<int>(size_) == 1) 
		return this->pop_front();

	Node* p = head;
	while (p->next()->next() != nullptr) {
		p = p->next();
	}

	Node* dado = p->next();
	p->next(nullptr);

	T aux = dado->data();
	delete [] dado;

	size_--;
	return aux;
}

template<typename T>
T structures::LinkedList<T>::pop_front() {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* p = head;
	head = p->next();

	T aux = p->data();
	delete [] p;

	size_--;
	return aux;
}

template<typename T>
void structures::LinkedList<T>::remove(const T& data) {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* p = head;
	for (size_t i = 0; i < size_; i++) {
		if (p->data() == data) {
			this->pop(i);
			return;
		}
		p = p->next();
	}

}

template<typename T>
bool structures::LinkedList<T>::empty() const {
	return (size_ == 0);
}

template<typename T>
bool structures::LinkedList<T>::contains(const T& data) const {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* p = head;
	while (p->next() != nullptr) {
		if (p->data() == data) return true;
		p = p->next();
	}
	return false;
}

template<typename T>
std::size_t structures::LinkedList<T>::find(const T& data) const {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* p = head;
	for (size_t i = 0; i < size_; i++) {
		if (p->data() == data) return i;
		p = p->next();
	}
	return size_;
}

template<typename T>
std::size_t structures::LinkedList<T>::size() const {
	return size_;
}

#endif
