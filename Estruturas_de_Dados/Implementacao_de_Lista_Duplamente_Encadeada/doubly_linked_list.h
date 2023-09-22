//! Copyright [2023] <Artur Soda>

#include <cstdio>
#include <exception>
#include <iterator>
#include <stdexcept>
namespace structures {

template<typename T>
class DoublyLinkedList {
 public:
    DoublyLinkedList();
    ~DoublyLinkedList();
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
    class Node {  // implementar cada um dos métodos de Node
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

    Node* head;  // primeiro da lista
    Node* tail;  // ultimo da lista
    std::size_t size_;
};

}  // namespace structures

template <typename T>
structures::DoublyLinkedList<T>::DoublyLinkedList() {
	head = nullptr;
	tail = nullptr;
	size_ = 0;
}

template<typename T>
structures::DoublyLinkedList<T>::~DoublyLinkedList() {
	this->clear();
}

template<typename T>
void structures::DoublyLinkedList<T>::clear() {
	while (!(this->empty())) {
		this->pop_front();
	}
}

template<typename T>
void structures::DoublyLinkedList<T>::push_back(const T& data) {
	Node* temp = new Node(data, nullptr, nullptr);

	if (this->empty()) {
		tail = head = temp;
		size_++;
		return;
	}

	temp->prev(tail);
	tail->next(temp);
	tail = temp;
	size_++;
}

template<typename T>
void structures::DoublyLinkedList<T>::push_front(const T& data) {
	Node* temp = new Node(data, nullptr, nullptr);
	if (temp == nullptr) return;

	if (this->empty()) {
		tail = head = temp;
		size_++;
		return;
	}

	temp->next(head);
	head->prev(temp);
	head = temp;
	size_++;
}

template<typename T>
void structures::DoublyLinkedList<T>::insert(const T& data, std::size_t index) {
	if (index > size_)
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
	for (size_t i = 0; i < (index-1); i++) {
		p = p->next();
	}

	Node* temp = new Node(data, p, p->next());
	if (temp == nullptr) return;

	p->next(temp);
	p->next()->prev(temp);
	size_++;
}

template<typename T>
void structures::DoublyLinkedList<T>::insert_sorted(const T& data) {
	Node* p = head;
	size_t i = 0;
	if (static_cast<int>(size_) > 0) {
		if (static_cast<int>(size_) == 1) {
			if (p->data() > data) {
				this->push_front(data);
			} else {
				this->push_back(data);
			}
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
T structures::DoublyLinkedList<T>::pop(std::size_t index) {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	if ((static_cast<int>(size_) < 0) || (index >= size_))
		throw std::out_of_range("Index fora do range");

	Node* p = head;
	for (size_t i = 0; i < (index-1); i++) {
		p = p->next();
	}

	Node* temp = p->next();
	p->next(temp->next());
	temp->next()->prev(p);

	T aux = temp->data();
	delete temp;
	size_--;
	return aux;
}

template<typename T>
T structures::DoublyLinkedList<T>::pop_back() {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* p = tail;

	if (size_ == 1) {
		head = nullptr;
		tail = nullptr;
	} else {
		tail = p->prev();
		tail->next(nullptr);
	}

	T aux = p->data();
	delete p;
	size_--;
	return aux;
}

template<typename T>
T structures::DoublyLinkedList<T>::pop_front() {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* p = head;

	if (size_ == 1) {
		head = tail = nullptr;
	} else {
		head = p->next();
		head->prev(nullptr);
	}

	T aux = p->data();
	delete  p;
	size_--;
	return aux;
}

template<typename T>
void structures::DoublyLinkedList<T>::remove(const T& data) {
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
bool structures::DoublyLinkedList<T>::empty() const {
	return (size_ == 0);
}

template<typename T>
bool structures::DoublyLinkedList<T>::contains(const T& data) const {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* p = head;
	while (p->next() != nullptr) {
		if (p->data() == data) return true;
		p = p->next();
	}
	return false;
}

template<typename T>
T& structures::DoublyLinkedList<T>::at(std::size_t index) {
	if (this->empty()) throw std::out_of_range("Lista vazia");
	if (index >= size_) throw std::out_of_range("index fora do range");

	Node* p = head;
	for (size_t i = 0; i < index; i++) {
		p = p->next();
	}

	return p->data();
}

template<typename T>
const T& structures::DoublyLinkedList<T>::at(std::size_t index) const {
	if (this->empty()) throw std::out_of_range("Lista vazia");
	if (index >= size_) throw std::out_of_range("index fora do range");

	Node* p = head;
	for (size_t i = 0; i < index; i++) {
		p = p->next();
	}

	return p->data();
}


template<typename T>
std::size_t structures::DoublyLinkedList<T>::find(const T& data) const {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* p = head;
	for (size_t i = 0; i < size_; i++) {
		if (p->data() == data) return i;
		p = p->next();
	}
	return size_;
}

template<typename T>
std::size_t structures::DoublyLinkedList<T>::size() const {
	return size_;
}

