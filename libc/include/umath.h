#ifndef _MATH_H
#define _MATH_H 1
 
#include <sys/cdefs.h>
 
#include <stddef.h>
#include <stdint.h> 
#ifdef __cplusplus
extern "C" {
#endif
 
float sin(float x, float y);
float cos(float x, float y);
char rotate();
void encodeGdtEntry(uint8_t *target, struct GDT source);

#ifdef __cplusplus
}
#endif
 
#endif
