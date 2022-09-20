#include <umath.h> 

int rotate(int t, int x, int y){
    int f = x;
    x -= t * y;
    y += t * f;
    f = (3 - x * x - y * y) / 2;
    x *= f;
    y *= f;
}