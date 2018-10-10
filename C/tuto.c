#include <stdio.h>

char *ptr = "hello";



// %p pointer, %d integer, %s string

int main(void){
	printf(" Address pointed by the pointer: %p, Address of the pointer: %p, String: %s \n", *ptr, &ptr, ptr);
	return 0;
}
