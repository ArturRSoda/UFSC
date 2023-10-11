//! Copyright [2023] <Artur Soda>

#include "array_list.h"
#include <iterator>
#include <stdexcept>

namespace structures {

template<typename T>
class BinaryTree {
public:
	BinaryTree();
    ~BinaryTree();

    void insert(const T& data);

    void remove(const T& data);

    bool contains(const T& data) const;

    bool empty() const;

    std::size_t size() const;

    ArrayList<T> pre_order() const;

    ArrayList<T> in_order() const;

    ArrayList<T> post_order() const;

private:
    struct Node {
        Node(const T& data_) {
			data = data_;
			left = nullptr;
			right = nullptr;
		}

        T data;
        Node* left;
        Node* right;
    };

    Node* root_;
    std::size_t size_;

	void pre_order_aux(ArrayList<T>& list, Node* root) const {
		if (root != nullptr) {
			list.push_back(root->data);
			this->pre_order_aux(list, root->left);
			this->pre_order_aux(list, root->right);
		}
	}

	void in_order_aux(ArrayList<T>& list, Node* root) const {
		if (root != nullptr) {
			this->in_order_aux(list, root->left);
			list.push_back(root->data);
			this->in_order_aux(list, root->right);
		}
	}


	void post_order_aux(ArrayList<T>& list, Node* root) const {
		if (root != nullptr) {
			this->post_order_aux(list, root->left);
			this->post_order_aux(list, root->right);
			list.push_back(root->data);
		}
	}

};

}  // namespace structures

template<typename T>
structures::BinaryTree<T>::BinaryTree() {
	root_ = nullptr;
	size_ = 0;
}

template<typename T>
structures::BinaryTree<T>::~BinaryTree() {
	while (!this->empty()) {
		this->remove(root_->data);
	}
}

template<typename T>
void structures::BinaryTree<T>::insert(const T& data) {
	if (this->contains(data)) return;

	Node* p = root_;
	Node* q = nullptr;

	Node* novo = new Node(data);

	if (this->empty()) {
		root_ = novo;
	}
	else {
		while (p != nullptr) {
			q = p;
			if (data < p->data) {
				p = p->left;
			}
			else {
				p = p->right;
			}
		}
		if (data < q->data) {
			q->left = novo;
		}
		else {
			q->right = novo;
		}
	}
	size_++;
}

template<typename T>
void structures::BinaryTree<T>::remove(const T& data) {
	if (this->empty()) throw std::out_of_range("Lista vazia");

	Node* p = root_;
	Node* q = nullptr;

	if (static_cast<int>(size_) == 1) {
		root_ == nullptr;
		delete p;
		size_--;
		return;
	}

	while (p != nullptr) {
		if (data == p->data) {
			if ((p->left == nullptr) && (p->right == nullptr)) {
				if (p->data < q->data) {
					q->left = nullptr;
				}
				else {
					q->right = nullptr;
				}
				delete p;
				size_--;
				return;
			}
			
			if (p->right != nullptr) {
				q = p->right;
				while (q->left != nullptr) {
					q = q->left;
				}
				T aux = q->data;
				this->remove(aux);
				p->data = aux;
			}
			else {
				q = p->left;
				while (q->right != nullptr) {
					q = q->right;
				}
				T aux = q->data;
				this->remove(aux);
				p->data = aux;
			}
		}
		else if (data < p->data) {
			q = p;
			p = p->left;
		}
		else {
			q = p;
			p = p->right;
		}
	}
}

template<typename T>
bool structures::BinaryTree<T>::contains(const T& data) const{
	Node* p = root_;
	while (p != nullptr) {
		if (data == p->data) return true;

		if (data < p->data) {
			p = p->left;	
		}
		else {
			p = p->right;
		}
	}
	return false;
}

template<typename T>
bool structures::BinaryTree<T>::empty() const {
	return (static_cast<int>(size_) == 0);
}

template<typename T>
std::size_t structures::BinaryTree<T>::size() const {
	return size_;
}

template<typename T>
structures::ArrayList<T> structures::BinaryTree<T>::pre_order() const {
	ArrayList<T> list;
	pre_order_aux(list, root_);
	return list;
}

template<typename T>
structures::ArrayList<T> structures::BinaryTree<T>::in_order() const {
	ArrayList<T> list;
	in_order_aux(list, root_);
	return list;
}

template<typename T>
structures::ArrayList<T> structures::BinaryTree<T>::post_order() const {
	ArrayList<T> list;
	post_order_aux(list, root_);
	return list;
}

