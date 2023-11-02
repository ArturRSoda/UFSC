#include <cctype>
#include <iostream>
#include <locale>
#include <string>

#include "trie_tree.h"

using namespace std;

int main() {

	structures::TrieTree<string> T;

	T.insert("artur", 100, 200);
	T.insert("artur soda", 100, 200);

	string x = "Artur ";
	cout << "tem -> " << T.contain(x) << endl;
	cout << "prefix -> " << T.get_qtd_prefix(x);


	return 0;
}
