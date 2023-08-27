#include <stdio.h>
#include <string.h>

int f(int a) {
	if (a % 2 != 0 && a < 20) {
		return a;
	} else if (&a) {
		if (a < 0) return 2*a;
	} else {
		return 27;
	}
	return 31;
}


int main() {

	char s1[] = "HELLO";
	char* s2 = "WORLD";
	char* s3 = s2;
	char *s4 = malloc(sizeof(char));
	strcpy(s4, s3);
	printf("%s %s\n", s1, s4);



	return 0;
}
