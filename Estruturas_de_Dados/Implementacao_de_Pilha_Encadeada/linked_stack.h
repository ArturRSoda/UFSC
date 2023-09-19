//! Copyright [2023] <Artur Soda>

#include <stdexcept>
namespace structures {

template<typename T>
class LinkedStack {
 public:
    LinkedStack();

    ~LinkedStack();

    void clear();  // limpa pilha

    void push(const T& data);  // empilha

    T pop();  // desempilha

    T& top() const;  // dado no topo

    bool empty() const;  // pilha vazia

    std::size_t size() const;  // tamanho da pilha

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

        T& data() {
			return data_;
		}  // getter: info

        const T& data() const {
			return data_;
		}  // getter-constante: info

        Node* next() {   // getter: próximo
			return next_;
		}
        const Node* next() const {
			return next_;
		}  // getter-constante: próximo

        void next(Node* next) {
			next_ = next;
		}  // setter: próximo

     private:
        T data_;
        Node* next_{nullptr};
    };

    Node* top_;  // nodo-topo
    std::size_t size_;  // tamanho
};

}  // namespace structures

template<typename T>
structures::LinkedStack<T>::LinkedStack() {
	top_ = nullptr;
	size_ = 0;
}

template<typename T>
structures::LinkedStack<T>::~LinkedStack() {
	this->clear();
}

template<typename T>
void structures::LinkedStack<T>::clear() {
	while (size_ > 0) {
		this->pop();
	}
}

template<typename T>
void structures::LinkedStack<T>::push(const T& data) {
	Node* novo = new Node(data, top_);
	if (novo == nullptr) return;
	top_ = novo;
	size_++;
}

template<typename T>
T structures::LinkedStack<T>::pop() {
	if (this->empty()) throw std::out_of_range("Lista vazia");
	
	Node* dado = top_;
	top_ = top_->next();
	
	size_--;
	T aux = dado->data();
	
	delete [] dado;
	return aux;
}

template<typename T>
T& structures::LinkedStack<T>::top() const {
    if (this->empty()) throw std::out_of_range("lista vazia");
	return top_->data();
}

template<typename T>
bool structures::LinkedStack<T>::empty() const {
	return (size_ == 0);
}

template<typename T>
std::size_t structures::LinkedStack<T>::size() const {
	return size_;
}



