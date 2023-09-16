#include <cstdlib>
#include <fstream>
#include <iostream>
#include <algorithm>
#include <stdio.h>
#include <string>
#include <system_error>
#include "./array_stack.h"
#include "array_queue.h"

using namespace std;

typedef struct {
	string name;
	int height;
	int width;
	int x;
	int y;
	string matriz;
} cenario;

typedef struct {
	int x;
	int y;
} position;

bool verify_file(ifstream&, int&);
cenario* search(ifstream&, int);
int count_floor(cenario);

int main() {

    char xmlfilename[100];

    std::cin >> xmlfilename;  // entrada
	ifstream xml_file (xmlfilename);
	int n_cenarios = 0;

	if (!verify_file(xml_file, n_cenarios)) {
		cout << "erro" << "\n";
		return -1;
	}
	xml_file.close();


	ifstream xml_file2 (xmlfilename);
	cenario* cenarios = search(xml_file2, n_cenarios);
	/*
	for (int i = 0; i < n_cenarios; i++) {
		cout << cenarios[i].name << endl;
		cout << cenarios[i].height << endl;
		cout << cenarios[i].width << endl;
		cout << cenarios[i].x << endl;
		cout << cenarios[i].y << endl;

		for (int k = 0; k < cenarios[i].height; k++) {
			for (int j = 0; j < cenarios[i].width; j++) {
				cout << cenarios[i].matriz[(k * cenarios[i].width) + j];
			}
			cout << endl;
		}

	}
	*/
	for (int i = 0; i < n_cenarios; i++) {
		cout << cenarios[i].name << " " << count_floor(cenarios[i]) << "\n"; 

	}


	delete [] cenarios;
	xml_file.close();
	xml_file2.close();

    return 0;
}

int count_floor(cenario cn) {
	structures::ArrayQueue<position> queue;
	position pos;

	string c_matriz = "";

	int height = cn.height;
	int width = cn.width;
	int x = cn.x;
	int y = cn.y;
	string matriz = cn.matriz;

	if (matriz[(x * width) + y] == '0') return 0;

	for (int i = 0; i < (height*width); i++) c_matriz.push_back('0');

	pos.x = x;
	pos.y = y;
	c_matriz[(x * width) + y] = '1';
	queue.enqueue(pos);

	while (queue.size() > 0) {
		position p = queue.dequeue();

		if (p.x-1 >= 0)
			if (matriz[(p.x-1 * width) + p.y] == '1')
				if (c_matriz[(p.x-1 * width) + p.y] == '0') {
					position pos = {p.x-1, p.y};
					c_matriz[(pos.x * width) + pos.y] = '1';
					queue.enqueue(pos);
				}

		if (p.x+1 <= height)
			if (matriz[(p.x+1 * width) + p.y] == '1')
				if (c_matriz[(p.x+1 * width) + p.y] == '0') {
					position pos = {p.x+1, p.y};
					c_matriz[(pos.x * width) + pos.y] = '1';
					queue.enqueue(p);
				}

		if (p.y-1 >= 0)
			if (matriz[(p.x * width) + p.y-1] == '1')
				if (c_matriz[(p.x * width) + p.y-1] == '0') {
					position pos = {p.x, p.y-1};
					c_matriz[(pos.x * width) + pos.y] = '1';
					queue.enqueue(p);
				}

		if (p.y+1 <= width)
			if (matriz[(p.x * width) + p.y+1] == '1')
				if (c_matriz[(p.x * width) + p.y+1] == '0') {
					position pos = {p.x, p.y+1};
					c_matriz[(pos.x * width) + pos.y] = '1';
					queue.enqueue(p);
				}
	}
	cout << endl;
	for (int i = 0; i < height; i++) {
		for (int j = 0; j < width; j++) {
			cout << c_matriz[(i*width)+j];
		}
		cout << endl;
	}
	return count(c_matriz.begin(), c_matriz.end(), '1');

}

cenario* search(ifstream& xml_file, int n_cenarios) {

	structures::ArrayStack<string> stack;
	string line;

	cenario* array_cenarios = new cenario[n_cenarios];
	int count_cn = 0;
	cenario cn;


	bool id_matriz = false;

	string name;
	int height;
	int width;
	int x;
	int y;
	string matriz;

	while (getline(xml_file, line)) {
		char character;
		string id = "";
		string value = "";
		bool openid = false;
		bool closeid = false;

		for (int i = 0; i < line.length(); i++) {
			character = line[i];

			if (!openid) {
				if (character == '<') {
					if (line[i+1] == '/') closeid = true;
					openid = true;


				} else {
					value += character;
					if (id_matriz && (value.size() == width)) {
						matriz += value;
					}
				}

			} else {
				if (character == '>') {
					if (closeid) {
						id.erase(0, 1);

						if (id == "nome") name = value;
						else if (id == "altura") height = stoi(value);
						else if (id == "largura") width = stoi(value);
						else if (id == "x") x = stoi(value);
						else if (id == "y") y = stoi(value);
						else if (id == "matriz") id_matriz = false;

						if (id == "cenario") {
							cn.name = name;
							cn.height = height;
							cn.width = width;
							cn.x = x;
							cn.y = y;

							cn.matriz = matriz;
							matriz.clear();

							array_cenarios[count_cn] = cn;
							count_cn++;
						}

					} else {
						if (id == "matriz") {
							id_matriz = true;
						}
					}

					value.clear();
					id.clear();
					openid = false;
					closeid = false;

				} else { 
					id += character;
				}
			}
		}
	}
	return array_cenarios;
}

bool verify_file(ifstream& xml_file, int& n_cenarios) {

	structures::ArrayStack<string> stack;
	string line;

	while (getline(xml_file, line)) {
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
						if (stack.pop() != id) return false;

					} else {
						if (id == "cenario") n_cenarios++;
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
	}

	return (stack.empty());
}

