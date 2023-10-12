//! Copyright [2023] <Artur Soda>

#include "array_list.h"
#include <algorithm>
#include <array>
#include <iterator>
#include <stdexcept>

namespace structures {

template<typename T>
class BinaryTree {
public:
    ~BinaryTree() {
	}

    void insert(const T& data) {
		if (!this->contains(data)) {
			root_ = this->insert_aux(data, root_);
			size_++;
		}
	}

	bool contains(const T& data) const {
		return this->contains_aux(data, root_);
	}

    void remove(const T& data) {
		if (this->contains(data)) {
			root_ = this->remove_aux(data, root_);
			size_--;
		}
	}

	bool empty() const {
		return (size_ == 0);
	}

	std::size_t size() const {
		return size_;
	}

	ArrayList<T> pre_order() const {
		ArrayList<T> list;
		this->pre_order_aux(list, root_);
		return list;
	}

	ArrayList<T> in_order() const {
		ArrayList<T> list;
		this->in_order_aux(list, root_);
		return list;
	}

	ArrayList<T> post_order() const {
		ArrayList<T> list;
		this->post_order_aux(list, root_);
		return list;
	}

private:
    struct Node {
        T data;
        Node* left;
        Node* right;
    };

    Node* root_;
    std::size_t size_;

	Node* new_node(const T& data) {
		Node* novo = new Node();
		novo->data = data;
		novo->left = nullptr;
		novo->right = nullptr;
		return novo;
	}

	Node* insert_aux(const T& data, Node* root) {
		if (root == nullptr) {
			root = this->new_node(data);
		}
		else if (data < root->data) {
			root->left = this->insert_aux(data, root->left);
		}
		else if (data > root->data) {
			root->right = this->insert_aux(data, root->right);
		}
		return root;
	}

	bool contains_aux(const T& data, Node* root) const {
		if (root == nullptr) return false;
		else if (root->data == data) return true;
		else if (data < root->data) return this->contains_aux(data, root->left);
		else return this->contains_aux(data, root->right);
	}

	Node* remove_aux(const T& data, Node* root) {
		if (root == nullptr) return root;
		else if (data < root->data) root->left = this->remove_aux(data, root->left);
		else if (data > root->data) root->right = this->remove_aux(data, root->right);
		else {
			if ((root->left == nullptr) && (root->right == nullptr)) {
				delete root;
				root = nullptr;
			}
			else if (root->left == nullptr) {
				Node* temp = root;
				root = root->right;
				delete temp;
			}
			else if (root->right == nullptr) {
				Node* temp = root;
				root = root->left; 
				delete temp;
			}
			else {
				Node* temp = this->min_node(root->right);
				root->data = temp->data;
				root->right = this->remove_aux(temp->data, root->right);
			}
		}
		return root;
	}

	Node* min_node(Node* root) {
		while (root->left != nullptr) {
			root = root->left;
		}
		return root;
	}

	void pre_order_aux(ArrayList<T>& list, Node* root) const {
		if (root == nullptr) return;
		list.push_back(root->data);
		this->pre_order_aux(list, root->left);
		this->pre_order_aux(list, root->right);
	}

	void in_order_aux(ArrayList<T>& list, Node* root) const {
		if (root == nullptr) return;
		this->in_order_aux(list, root->left);
		list.push_back(root->data);
		this->in_order_aux(list, root->right);
	}

	void post_order_aux(ArrayList<T>& list, Node* root) const {
		if (root == nullptr) return;
		this->post_order_aux(list, root->left);
		this->post_order_aux(list, root->right);
		list.push_back(root->data);
	}

};

}


