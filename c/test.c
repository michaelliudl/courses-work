#include <stdio.h>

void butler(void);

int main(void)
{
	int number_of_dogs;
	int num;
	int feet, fathoms;
	int n, n2, n3;
	printf("How many dogs do you have?\n");
	// scanf("%d", &number_of_dogs);
	printf("So you have %d dog(s).\n", number_of_dogs);
	num = 1;
	printf("I am a simple ");
	printf("computer.\n");
	printf("My favorite number is %d because it is first.\n", num);
	fathoms = 2;
	feet = 6 * fathoms;
	printf("There are %d feet in %d fathoms.\n", feet, fathoms);
	printf("Yes I said %d feet!\n", 6 * fathoms);
	printf("I will summon the butler function.\n");
	butler();
	printf("Yes. Bring me some tea and writable DVDs.\n");
	n = 5;
	n2 = n * n;
	n3 = n2 * n2;
	printf("n = %d, n squared = %d, n cubed = %d.\n", n, n2, n3);
	getchar();
	return 0;
}

void butler(void)
{
	printf("You rang, sir?\n");
}