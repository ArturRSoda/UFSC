#include <stdexcept>
#include <string>

namespace structures {

template<typename T>
class TrieTree {
public:

    struct Node {

		Node() {
			qtd_prefix = 0;
			position = 0;
			length = 0;

			for (int i = 0; i < 26; i++) {
				children[i] = nullptr;
			}
		}

		Node *children[26];
		unsigned long qtd_prefix;
		unsigned long position;
		unsigned long length;
    };

    Node* root_;

	TrieTree() {
		root_ = new Node();
	}
	
	~TrieTree() {
		this->destructor_aux(root_);
		root_ = nullptr;
	}

    void insert(std::string key, unsigned long position, unsigned long length) {
		this->to_lower(key);

		if (!this->contain(key)) {
			Node* p = root_;

			for (int i = 0; i < key.length(); i++) {
				int index = key[i] - 'a';

				if (p->children[index] == nullptr) {
					p->children[index] = new Node();
				}
				p = p->children[index];
				p->qtd_prefix++;
			}
			p->position = position;
			p->length = length;
		}
	}

	bool contain(std::string key) {
		Node* p = end_of_key(key);
		if (p == nullptr) {
			return false;
		} else {
			return true;
		}
	}

	unsigned long get_qtd_prefix(std::string key) {
		Node* p = this->end_of_key(key);
		if (p == nullptr) {
			throw std::invalid_argument("key doesnt exist");
		} else {
			return p->qtd_prefix;
		}
	}

	unsigned long get_position(std::string key) {
		Node* p = this->end_of_key(key);
		if (p == nullptr) {
			throw std::invalid_argument("key doesnt exist");
		} else {
			return p->position;
		}
	}

	unsigned long get_length(std::string key) {
		Node* p = this->end_of_key(key);
		if (p == nullptr) {
			throw std::invalid_argument("key doesnt exist");
		} else {
			return p->length;
		}
	}


private:

	void destructor_aux(Node* root) {
		for (int i = 0; i < 26; i++) {
			if (root->children[i] != nullptr) {
				this->destructor_aux(root->children[i]);
			}
		}
		delete root;
	}

	void to_lower(std::string& text) {
		for (int i = 0; i < text.length(); i++) {
			text[i] = tolower(text[i], std::locale());
		}
	}

	Node* end_of_key(std::string key) {
		to_lower(key);
		Node* p = root_;
		for (int i = 0; i < key.length(); i++) {
			int index = key[i] - 'a';
			if (p->children[index] == nullptr) {
				return nullptr;
			} else {
				p = p->children[index];
			}
		}
		return p;
	}
};

}
