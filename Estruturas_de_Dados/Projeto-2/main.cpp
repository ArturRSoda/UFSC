#include <iostream>
#include <fstream>
#include <string>

#include "trie_tree.h"

using namespace std;


void read_file(ifstream& file, structures::TrieTree<string>& tree);
void search_tree(structures::TrieTree<string>& tree);

int main() {

	structures::TrieTree<string> tree;
	string filename;

	cin >> filename;  // entrada

	ifstream file(filename);

	read_file(file, tree);
	search_tree(tree);

	return 0;
}

void read_file(ifstream& file, structures::TrieTree<string>& tree) {
	
	string line;
	string word;
	int length;
	int position = 0;

	while (getline(file, line)) {
		int end = line.find(']');
		length = line.length();	
		word = line.substr(1, end-1);

		tree.insert(word, position, length);

		position += length+1;
}

}

void search_tree(structures::TrieTree<string>& tree) {
	string word;

	while (true) {  
		cin >> word;

		if (word.compare("0") == 0) break;
		

		if (!tree.contain(word)) {
			cout << word << " is not prefix" << endl;
		}
		else {
			int qtd_prefix = tree.get_qtd_prefix(word);
			int position = tree.get_position(word);
			int length = tree.get_length(word);

			cout << word << " is prefix of " << qtd_prefix << " words" << endl;

			if (length != 0)
				cout << word << " is at (" << position << "," << length << ")" << endl;
		}
	}
}
