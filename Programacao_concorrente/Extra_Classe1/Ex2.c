#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void inputArray(int* arr, int size){
	int x;
	for (int i = 0; i < size; i++){
		scanf("%d", &x);
		arr[i] = x;
	}
}

void printArray(int* arr, int size) {
	for (int i = 0; i < size; i++)
		printf("%d ", arr[i]);
	printf("\n");
}

int sortAscending(int* num1, int* num2) {
	return (*num1 - *num2);
}

int sortDescending(int* num1, int* num2) {
	return (*num2 - *num1);
}

void sort(int* arr, int size, int (* compare)(int*, int*)) {
	int i = 0;
	int tmp;
	bool exit = true;
	while (1) {
		if (compare(&arr[i], &arr[i+1]) > 0) {
			tmp = arr[i];
			arr[i] = arr[i+1];
			arr[i+1] = tmp;
			exit = false;
		}

		i++;

		if (i >= (size-1)) {

			if (exit) {
				break;
			} else {
				i = 0;
				exit = true;
			}
		}
	}
}

int main()
{
	size_t MAX_SIZE = 100;
	int arr[MAX_SIZE];
	int size;

	// Input array size and elements.
	printf("Enter array size: ");
	scanf("%d", &size);

	printf("Enter elements in array: ");
	inputArray(arr, size);

	printf("\n\nElements before sorting: ");
	printArray(arr, size);

	// Sort and print sorted array in ascending order.
	printf("\n\nArray in ascending order: ");
	sort(arr, size, sortAscending);
	printArray(arr, size);

	// Sort and print sorted array in descending order.
	printf("\nArray in descending order: ");
	sort(arr, size, sortDescending);
	printArray(arr, size);

	return 0;
}
