// MathLibrary.h - Contains declarations of math functions
#pragma once

#ifdef DLLCPP_EXPORTS
#define DLLCPP_API __declspec(dllexport)
#else
#define DLLCPP_API __declspec(dllimport)
#endif

extern "C" DLLCPP_API void lap(unsigned char *data, unsigned char *helper, unsigned int offset, size_t size, unsigned int width);

