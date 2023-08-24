#include <stdio.h>
#include <string.h>

int main() {

	int dataA[5][5];
	int dataB[5][5];
	int TAM = 5;

	int count = 1;
	for (int j = 0; j < 5; j++) {
		for (int i = 0; i < 5; i++) {
			dataA[i][j] = count;
			count++;
		}
	}


	for (int i = 0; i < TAM; i++)
	  for (int j = 0; j < TAM; j++)
		dataB[i*TAM+j] = dataA[i*TAM+j];



	for (int i = 0; i < 5; i++) {
		for (int j = 0; j < 5; j++) {
			printf("%d ", dataB[i][j]);
		}
		printf("\n");
	}
	return 0;
}
