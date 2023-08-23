#include <iostream>

using namespace std;

typedef struct {
	float x, y;
} ponto_t;

bool anoa(int x) {
	return (x % 400 == 0 || x % 100) && x % 4 == 0;
}

bool anob(int x) {
	return !(x % 400) || ((x % 100) && !(x%4));
}

bool anoc(int x) {
	return x % 400 == 0 || (x % 100 && x % 4 == 0);
}

bool anod(int x) {
	if (x % 4 == 0) {
		if (x % 100) return -1;
		else if (!(x % 400)) return 1;
		return 0;
	}
}

bool anoe(int x) {
	return (!(x % 400) || (x % 100)) && !(x%4);
}

bool anof(int x) {
	if (x % 4 == 0) {
		if (x % 100 == 0) return 0;
		else if (!(x % 400)) return 1;
		return 1;
	} 
}

int main () {
	cout << "2000 : " << anof(2000) << endl;
	cout << "2020 : " << anof(2020) << endl;
	cout << "1600 : " << anof(1600) << endl;
	cout << "2400 : " << anof(2400) << endl;

	cout << "2200 : " << anof(2200) << endl;
	cout << "1700 : " << anof(1700) << endl;
	cout << "1800 : " << anof(1800) << endl;
	cout << "1900 : " << anof(1900) << endl;
	cout << "2100 : " << anof(2100) << endl;
	cout << "2300 : " << anof(2300) << endl;
	cout << "2500 : " << anof(2500) << endl;
	cout << "2600 : " << anof(2600) << endl;

	return 0;
}
