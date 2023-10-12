//! Copyright [2023] <Artur Soda>

#include "array_list.h"
#include <array>
#include <iterator>
#include <stdexcept>

namespace structures {

template<typename T>
class BinaryTree {
public:
	BinaryTree() {
		root_ = nullptr;
		size_ = 0;
	}

    ~BinaryTree() {
		ArrayList<T> list = this->pre_order();
		while (!this->empty()) {
			this->remove(list.pop_back());
		}
	}

    void insert(const T& data) {
		printf("tentando inserir = %d \n", data);
		if (!this->contains(data)) {
			printf("entro \n");
			this->insert_aux(data, root_);
			size_++;
			printf("somo \n");
			ArrayList<T> list = this->pre_order();
			printf("size = %d \n", size_);
			printf("contais = %d \n", this->contains(data));
			printf("root == null : %b \n", root_ == nullptr);
			printf("list size = %d \n", list.size());
		}
	}

    void remove(const T& data) {
		if (this->contains(data)) size_--;
		root_ = this->remove_aux(data, root_);
	}

	bool contains(const T& data) const {
		return this->contains_aux(data, root_);
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

	Node* min_node(Node* root) {
		if (root == nullptr)
			return nullptr;
		if (root->left != nullptr)
			return this->min_node(root->left);
		return root;
	}

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

	bool contains_aux(const T& data, Node* root) const {
		if (root == nullptr)
			return false;
		else if (data < root->data)
			return this->contains_aux(data, root->left);
		else if (data > root->data)
			return this->contains_aux(data, root->right);
		else
			return true;
	}

	void insert_aux(const T& data, Node* root) {
		Node* novo;
		if (root == nullptr) {
			printf("entro aki \n");
			root = new Node(data);
		}
		else if (data < root->data) {
			if (root->left == nullptr) {
				novo = new Node(data);
				root->left = novo;
			} else {
				this->insert_aux(data, root->left);
			}
		} else if (data > root->data) {
			if (root->right == nullptr) {
				novo = new Node(data);
				root->right = novo;
			} else {
				this->insert_aux(data, root->right);
			}
		}
	}

	Node* remove_aux(const T& data, Node* root) {
		if (root == nullptr)
			return nullptr;
		if (data < root->data) {
			root->left = this->remove_aux(data, root->left);
			return root;
		}
		else if (data > root->data) {
			root->right = this->remove_aux(data, root->right);
			return root;
		}
		else if ((root->left != nullptr) && (root->right != nullptr)) {
			Node* temp = this->min_node(root->right);
			root->data = temp->data;
			root->right = this->remove_aux(data, root->right);
			return root;
		}
		else if (root->left != nullptr) {
			Node* temp = root->left;
			delete root;
			return temp;
		}
		else if (root->right != nullptr) {
			Node* temp = root->right;
			delete root;
			return temp;
		}
		else {
			delete root;
			return nullptr;
		}
	}

};

}


