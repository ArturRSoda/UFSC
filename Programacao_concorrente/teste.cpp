#include <iostream>

using namespace std;

int main() { 
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
