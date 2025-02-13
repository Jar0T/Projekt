// DllCpp.cpp : Definiuje eksportowane funkcje dla aplikacji DLL.
//

#include "stdafx.h"
#include "DllCpp.h"

#include <iostream>
#include <thread>

const int mask[9] = 
	{ -1, -1, -1, 
	  -1, 8 -1, 
	  -1, -1, -1 };

void lap(unsigned char *data, unsigned char *helper, unsigned int offset, size_t size, unsigned int width) {
	for (unsigned int i = 3; i < size - 3; i++) {
		int val = 0;
		val += helper[i + offset - width - 3] * mask[0];
		val += helper[i + offset - width] * mask[1];
		val += helper[i + offset - width + 3] * mask[2];
		val += helper[i + offset - 3] * mask[3];
		val += helper[i + offset] * mask[4];
		val += helper[i + offset + 3] * mask[5];
		val += helper[i + offset + width - 3] * mask[6];
		val += helper[i + offset + width] * mask[7];
		val += helper[i + offset + width + 3] * mask[8];
		val = (val > 1 ? val : 0);
		data[i + offset] = (char)val;
	}
}

