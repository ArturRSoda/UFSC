#include <stdio.h>
#include <stdlib.h>

typedef struct MinMax {
	int min;
	int max;
} MinMax;


MinMax* getMinMax(int* array, const int SIZE) {
	int n;

	MinMax* m = (MinMax  *) malloc(sizeof(MinMax));
	m->min = array[0];
	m->max = array[0];

	for (int i = 1; i < SIZE; i++) {
		n = array[i];
		if (m->min > n) m->min = n;
		if (m->max < n) m->max = n;
	}

	return m;
}


int main() {

	int v[] = {3, 2, 1, 10, 9, 8};
	int tam = sizeof(v)/sizeof(v[0]);
	MinMax* mm;
	mm = getMinMax(v, tam);
	printf("Menor: %d\n", mm->min);
	printf("Maior: %d\n", mm->max);
	
	free(mm);
	return 0;
}

