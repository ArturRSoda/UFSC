//! Copyright [2023] <Artur Soda>

#include <stdexcept>
namespace structures {


template<typename T>
class LinkedQueue {
 public:
    LinkedQueue();

    ~LinkedQueue();

    void clear();  // limpar

    void enqueue(const T& data);  // enfilerar

    T dequeue();  // desenfilerar

    T& front() const;  // primeiro dado

    T& back() const;  // último dado

    bool empty() const;  // fila vazia

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

		void data(const T& data) {
		    data_ = data;
		}

     private:
        T data_;
        Node* next_{nullptr};
    };

    Node* head;  // nodo-cabeça
    Node* tail;  // nodo-fim
    std::size_t size_;  // tamanho
};

}  // namespace structures

template<typename T>
structures::LinkedQueue<T>::LinkedQueue() {
	head = nullptr;
	tail = nullptr;
	size_ = 0;
}

template<typename T>
structures::LinkedQueue<T>::~LinkedQueue() {
	this->clear();
}

template<typename T>
void structures::LinkedQueue<T>::clear() {
	while (size_ > 0) {
		this->dequeue();
	}
}

template<typename T>
void structures::LinkedQueue<T>::enqueue(const T& data) {
	Node* novo;
	novo = reinterpret_cast<Node*>(malloc(sizeof(Node)));
	novo->data(data);
	if (novo == nullptr) return;

	if (this->empty()) {
		head = tail = novo;
		size_++;
		return;
	}
	tail->next(novo);
	tail = novo;
	size_++;
}

template<typename T>
T structures::LinkedQueue<T>::dequeue() {
	if (this->empty()) throw std::out_of_range("Lista vazia");


	Node* temp = head;
	T aux = head->data();

	head = head->next();
	if (head == nullptr)
		tail = nullptr;

	free(temp);
	size_--;
	return aux;
}

template<typename T>
T& structures::LinkedQueue<T>::front() const {
	if (this->empty()) throw std::out_of_range("Lista vazia");
	return head->data();
}


template<typename T>
T& structures::LinkedQueue<T>::back() const {
	if (this->empty()) throw std::out_of_range("Lista vazia");
	return tail->data();
}

template<typename T>
bool structures::LinkedQueue<T>::empty() const {
	return (size_ == 0);
}

template<typename T>
std::size_t structures::LinkedQueue<T>::size() const {
	return size_;
}


