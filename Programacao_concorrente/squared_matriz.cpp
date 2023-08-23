#include <cstdio>
#include <iostream>

using namespace std;

int main() {
	const int COL = 7;
	const int ROW = 7;

	int data[ROW][COL] {};
	

	cout << "A:" << endl;

	for (auto &row: data) {
		for (auto &e: row) {
			e = 0;
		}
	}

    for (int i = 0; i < ROW; i++) {
        for (int j = i; j >= 0; j--) {
            data[i][j] = rand() % 100 + 1;
        }
    }

	for (int i = 0; i < ROW; i++) {
		for (int j = 0; j < COL; j++) {
			printf("%d ", data[i][j]);
		}
		cout << endl;
	}

	cout << "B:" << endl;

	for (auto &row: data) {
		for (auto &e: row) {
			e = 0;
		}
	}

    for (int i = 0; i < ROW; i++) {
        for (int j = i; j < COL; j++) {
            data[i][j] = rand() % 100 + 1;
        }
    }

	for (int i = 0; i < ROW; i++) {
		for (int j = 0; j < COL; j++) {
			printf("%d ", data[i][j]);
		}
		cout << endl;
	}

	cout << "C:" << endl;

	for (auto &row: data) {
		for (auto &e: row) {
			e = 0;
		}
	}

    for (int i = 0; i < COL; i++) {
        for (int j = i; j < ROW; j++) {
            data[i][j] = rand() % 100 + 1;
        }
    }

	for (int i = 0; i < ROW; i++) {
		for (int j = 0; j < COL; j++) {
			printf("%d ", data[i][j]);
		}
		cout << endl;
	}

	cout << "D:" << endl;

	for (auto &row: data) {
		for (auto &e: row) {
			e = 0;
		}
	}

    for (int i = 0; i <= ROW; i++) {
        for (int j = i; j <= COL; j++) {
            data[i][j] = rand() % 100 + 1;
        }
    }
	
	for (int i = 0; i < ROW; i++) {
		for (int j = 0; j < COL; j++) {
			printf("%d ", data[i][j]);
		}
		cout << endl;
	}

	cout << "E:" << endl;

	for (auto &row: data) {
		for (auto &e: row) {
			e = 0;
		}
	}

    for (int i = 0; i < ROW; i++) {
        for (int j = i; j >= 0; j--) {
            data[j][i] = rand() % 100 + 1;
        }
    }
	
	for (int i = 0; i < ROW; i++) {
		for (int j = 0; j < COL; j++) {
			printf("%d ", data[i][j]);
		}
		cout << endl;
	}

	cout << "F:" << endl;

	for (auto &row: data) {
		for (auto &e: row) {
			e = 0;
		}
	}

    for (int i = 0; i < ROW; i++) {
        for (int j = i; j < COL; j++) {
            data[j][i] = rand() % 100 + 1;
        }
    }

	for (int i = 0; i < ROW; i++) {
		for (int j = 0; j < COL; j++) {
			printf("%d ", data[i][j]);
		}
		cout << endl;
	}

	return 0;
}
