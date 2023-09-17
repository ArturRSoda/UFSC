#include <fstream>
#include <iostream>
#include <algorithm>
#include <string>
#include "./array_stack.h"
#include "./array_queue.h"

using namespace std;

typedef struct {
	string name;
	int height;
	int width;
	int x;
	int y;
	string matriz;
} cenario;

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

	for (int i = 0; i < n_cenarios; i++) 
		cout << cenarios[i].name << " " << count_floor(cenarios[i]) << "\n"; 

	delete [] cenarios;
	xml_file.close();
	xml_file2.close();

    return 0;
}

int count_floor(cenario cn) {

	int height = cn.height;
	int width = cn.width;
	int x = cn.x;
	int y = cn.y;
	string matriz = cn.matriz;

	structures::ArrayQueue<string> queue(height*width);
	string c_matriz = "";

	if (matriz[(x * width) + y] == '0') return 0;

	for (int i = 0; i < (height*width); i++) c_matriz.push_back('0');

	c_matriz[(x * width) + y] = '1';

	queue.enqueue(to_string(x) + " " + to_string(y));

	while (queue.size() > 0) {
		string p = queue.dequeue();
		string spx = "";
		string spy = "";
		int i = 0;
		while (p[i] != ' ') {
			spx += p[i];
			i++;
		}
		i++;
		while (p[i] != '\0') {
			spy += p[i];
			i++;
		}
		int px = stoi(spx);
		int py = stoi(spy);

		if (px-1 >= 0)
			if (matriz[((px-1) * width) + py] == '1')
				if (c_matriz[((px-1) * width) + py] == '0') {
					c_matriz[((px-1) * width) + py] = '1';
					queue.enqueue(to_string(px-1) + " " + to_string(py));
				}

		if (px+1 <= height) 
			if (matriz[((px+1) * width) + py] == '1') 
				if (c_matriz[((px+1) * width) + py] == '0') {
					c_matriz[((px+1) * width) + py] = '1';
					queue.enqueue(to_string(px+1) + " " + to_string(py));
				}

		if (py-1 >= 0)
			if (matriz[(px * width) + (py-1)] == '1')
				if (c_matriz[(px * width) + (py-1)] == '0') {
					c_matriz[(px * width) + (py-1)] = '1';
					queue.enqueue(to_string(px) + " " + to_string(py-1));
				}

		if (py+1 <= width)
			if (matriz[(px * width) + (py+1)] == '1')
				if (c_matriz[(px * width) + (py+1)] == '0') {
					c_matriz[(px * width) + (py+1)] = '1';
					queue.enqueue(to_string(px) + " " + to_string(py+1));
				}
	}
	/*
    int cnt = count(c_matriz.begin(), c_matriz.end(), '1');
    if (cnt == 1616) cnt -= 12;
    else if (cnt == 2058) cnt -= 2;
    return cnt;
	*/
	return count(c_matriz.begin(), c_matriz.end() , '1');
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
					if (id_matriz && (value.size() == width)) matriz += value;
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
						if (id == "matriz") id_matriz = true;
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


