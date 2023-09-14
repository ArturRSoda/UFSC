#include <fstream>
#include <iostream>
#include <string>
#include "./array_stack.h"

using namespace std;

bool verify_file(structures::ArrayStack<string>& stack,
		         string line);

int main() {

    char xmlfilename[100];

    std::cin >> xmlfilename;  // entrada
    
	string line;
	ifstream xml_file (xmlfilename);
	structures::ArrayStack<string> stack;


	while (getline(xml_file, line)) {
		if (verify_file(stack, line)) {
			cout << "erro" << endl;
			xml_file.close();
			return -1;
		}
	}
	if (!(stack.empty())) {
		cout << "erro" << endl;
		xml_file.close();
		return -1;
	}

	xml_file.close();

    return 0;
}

bool verify_file(structures::ArrayStack<string>& stack,
		         string line) {
	char character;
	string id = "";
	bool closeid = false;
	bool openid = false;
	
	for (int i = 0; i < line.length(); i++) {
		character = line[i];

		if (!openid) {
			if (character == '<') {
				if (line[i+1] == '/') closeid = true;
				openid = true;
			}
		} else {
			if (character == '>') {

				if (closeid) {
					id.erase(0, 1);
					if (stack.pop() != id) return true;
					
				} else {
					stack.push(id);
				}
				
				id.clear();
				openid = false;
				closeid = false;

			} else {
				id += character;
			}
		}
	}
	return false;
}
