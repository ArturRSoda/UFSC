#include <iostream>
#include <stdlib.h>
#include <chrono>
#include <algorithm>

using namespace std;

int* randArray(int tam);
int partition(int* A, int inf_lim, int upper_lim);
void quickSort(int* A, int inf_lim, int upper_lim);
void heapify(int* A, int n, int i);
void heapSort(int* A, int n);

int main() {

	int* a1000_q = randArray(1000);
	int* a5000_q = randArray(5000);
	int* a10000_q = randArray(100000);
	int* a50000_q = randArray(50000);
	int* a100000_q = randArray(100000);

	int* a1000_h = new int[1000];
	int* a5000_h = new int[5000];
	int* a10000_h = new int[10000];
	int* a50000_h = new int[50000];
	int* a100000_h = new int[100000];

	copy(a1000_q, a1000_q+1000, a1000_h);
	copy(a5000_q, a5000_q+1000, a5000_h);
	copy(a10000_q, a10000_q+1000, a10000_h);
	copy(a50000_q, a50000_q+1000, a50000_h);
	copy(a100000_q, a100000_q+1000, a100000_h);

	auto start = chrono::high_resolution_clock::now();
	quickSort(a1000_q, 0, 999);
	auto stop = chrono::high_resolution_clock::now();
	auto a1000_quicksort_temp = chrono::duration_cast<chrono::milliseconds>(stop - start);

	start = chrono::high_resolution_clock::now();
	quickSort(a5000_q, 0, 4999);
	stop = chrono::high_resolution_clock::now();
	auto a5000_quicksort_temp = chrono::duration_cast<chrono::milliseconds>(stop - start);
	
	start = chrono::high_resolution_clock::now();
	quickSort(a10000_q, 0, 9999);
	stop = chrono::high_resolution_clock::now();
	auto a10000_quicksort_temp = chrono::duration_cast<chrono::milliseconds>(stop - start);

	start = chrono::high_resolution_clock::now();
	quickSort(a50000_q, 0, 49999);
	stop = chrono::high_resolution_clock::now();
	auto a50000_quicksort_temp = chrono::duration_cast<chrono::milliseconds>(stop - start);

	start = chrono::high_resolution_clock::now();
	quickSort(a100000_q, 0, 99999);
	stop = chrono::high_resolution_clock::now();
	auto a100000_quicksort_temp = chrono::duration_cast<chrono::milliseconds>(stop - start);

	start = chrono::high_resolution_clock::now();
	heapSort(a1000_q, 1000);
	stop = chrono::high_resolution_clock::now();
	auto a1000_heapsort_temp = chrono::duration_cast<chrono::milliseconds>(stop - start);

	start = chrono::high_resolution_clock::now();
	heapSort(a5000_q, 5000);
	stop = chrono::high_resolution_clock::now();
	auto a5000_heapsort_temp = chrono::duration_cast<chrono::milliseconds>(stop - start);
	
	start = chrono::high_resolution_clock::now();
	heapSort(a10000_q, 10000);
	stop = chrono::high_resolution_clock::now();
	auto a10000_heapsort_temp = chrono::duration_cast<chrono::milliseconds>(stop - start);

	start = chrono::high_resolution_clock::now();
	heapSort(a50000_q, 50000);
	stop = chrono::high_resolution_clock::now();
	auto a50000_heapsort_temp = chrono::duration_cast<chrono::milliseconds>(stop - start);

	start = chrono::high_resolution_clock::now();
	heapSort(a100000_q, 100000);
	stop = chrono::high_resolution_clock::now();
	auto a100000_heapsort_temp = chrono::duration_cast<chrono::milliseconds>(stop - start);

	cout << "-------- Quick Sort -------" << endl;
	cout << "a1000_q   -> " << a1000_quicksort_temp.count() << " ms" << endl; 
	cout << "a5000_q   -> " << a5000_quicksort_temp.count() << " ms" << endl; 
	cout << "a10000_q  -> " << a10000_quicksort_temp.count() << " ms" << endl; 
	cout << "a50000_q  -> " << a50000_quicksort_temp.count() << " ms" << endl; 
	cout << "a100000_q -> " << a100000_quicksort_temp.count() << " ms" << endl; 
	cout << "---------------------------" << endl;

	cout << "-------- Heap Sort --------" << endl;
	cout << "a1000_h   -> " << a1000_heapsort_temp.count() << " ms" << endl; 
	cout << "a5000_h   -> " << a5000_heapsort_temp.count() << " ms" << endl; 
	cout << "a10000_h  -> " << a10000_heapsort_temp.count() << " ms" << endl; 
	cout << "a50000_h  -> " << a50000_heapsort_temp.count() << " ms" << endl; 
	cout << "a100000_h -> " << a100000_heapsort_temp.count() << " ms" << endl; 
	cout << "---------------------------" << endl;

	delete [] a1000_q;
	delete [] a5000_q;
	delete [] a10000_q;
	delete [] a50000_q;
	delete [] a100000_q;
	delete [] a1000_h;
	delete [] a5000_h;
	delete [] a10000_h;
	delete [] a50000_h;
	delete [] a100000_h;
	return 0;
}

int* randArray(int tam) {
	int* A = new int[tam];
	for (int i = 0; i < tam; i++) {
		A[i] = rand()%10;	
	}
	return A;
}

int partition(int* A, int inf_lim, int upper_lim) {
	int i;
	int j;

	int pivot = A[inf_lim];
	int count = 0;

	for (int i = inf_lim+1; i <= upper_lim; i++) {
		if (A[i] <= pivot) count++;
	}

	int pivotIndex = inf_lim+count;
	swap(A[pivotIndex], A[inf_lim]);
	
	i = inf_lim;
	j = upper_lim;

	while ((i < pivotIndex) && (j > pivotIndex)) {
		while (A[i] <= pivot) { i++; }
		while (A[j] > pivot) { j--; }
		if ((i < pivotIndex) && (j > pivotIndex)) {
			swap(A[i++], A[j--]);
		}
	}

	return pivotIndex;
}

void quickSort(int* A, int inf_lim, int upper_lim) {
	int i;
	if (upper_lim > inf_lim) {
		i = partition(A, inf_lim, upper_lim);
		quickSort(A, inf_lim, i-1);
		quickSort(A, i+1, upper_lim);
	}
}

void heapify(int* A, int n, int i) {
	int largest = i;
	int l = 2*i + 1;
	int r = 2*i + 2;

	if ((l < n) && (A[l] > A[largest])) {
		largest = l;
	}

	if ((r < n) && (A[r] > A[largest])) {
		largest = r;
	}

	if (largest != i) {
		swap(A[i], A[largest]);

		heapify(A, n, largest);
	}
}

void heapSort(int* A, int n) {

	for (int i = (n/2)-1; i >= 0; i--) {
		heapify(A, n, i);
	}

	for (int i = (n-1); i >= 0; i--) {
		swap(A[0], A[i]);
		heapify(A, i, 0);
	}
}

