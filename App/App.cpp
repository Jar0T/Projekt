#include <iostream>
#include <thread>
#include <vector>
#include <string>
#include "DllCpp.h"

extern "C" void _stdcall MyProc(unsigned char* data, unsigned char *helper, unsigned int offset, size_t size, unsigned int width);

struct BMP {
	unsigned char info[54];
	uint32_t width;
	uint32_t height;
	uint32_t row_padded;

	uint8_t *data;

	BMP(const char *fname) {
		read(fname);
	}

	void read(const char *fname) {
		FILE* f;
		fopen_s(&f, fname, "rb");

		fread(info, sizeof(unsigned char), 54, f);

		width = *(uint32_t*)&info[18];
		height = *(uint32_t*)&info[22];

		row_padded = (width * 3 + 3) & (~3);

		data = new uint8_t[row_padded * height];

		fread(data, sizeof(uint8_t), row_padded * height, f);

		fclose(f);
	}

	void saveAs(const char* fname) {
		FILE* f;

		fopen_s(&f, fname, "wb");

		fwrite(info, sizeof(unsigned char), 54, f);

		fwrite(data, sizeof(uint8_t), row_padded * height, f);

		fclose(f);
	}
};

int main(int argc, char **argv) {
	BMP bmp(argv[1]);
	//BMP bmp("04.bmp");
	std::vector<std::thread> threads;
	int maxThreads = 64;
	int numberOfThreads = (argc > 4 ? (std::stoi(argv[4]) > maxThreads ? maxThreads : std::stoi(argv[4])) : maxThreads);
	if (numberOfThreads > bmp.height - 2)
		numberOfThreads = bmp.height - 2;
	std::cout << "Number of threads: " << numberOfThreads << std::endl;
	std::cout << "Pixels in image: " << bmp.row_padded * bmp.height << std::endl;

	unsigned char* helper = new unsigned char[bmp.row_padded * bmp.height];
	
	for (int i = 0; i < bmp.row_padded * bmp.height; i++) {
		helper[i] = bmp.data[i];
	}
	
	if (strcmp(argv[3], "-c") == 0) {
		//C++ library
		for (int i = 0; i < numberOfThreads - 1; i++) {
			threads.push_back(
				std::thread(
					lap,
					bmp.data,
					helper,
					(i == 0 ?
						bmp.row_padded :
						bmp.row_padded * ((bmp.height - 2) / (numberOfThreads - 1)) * i),
					bmp.row_padded * ((bmp.height - 2) / (numberOfThreads - 1)),
					bmp.row_padded
				)
			);
		}
		threads.push_back(
			std::thread(
				lap,
				bmp.data,
				helper,
				bmp.row_padded * ((bmp.height - 2) / (numberOfThreads)) * (numberOfThreads - 1),
				bmp.row_padded * (bmp.height - 2) - bmp.row_padded * ((bmp.height - 2) / (numberOfThreads)) * (numberOfThreads - 1),
				bmp.row_padded
			)
		);
		for (int i = 0; i < threads.size(); i++) {
			threads[i].join();
		}
	}

	if (strcmp(argv[3], "-a") == 0) {
		//ASM library
		for (int i = 0; i < numberOfThreads - 1; i++) {
			threads.push_back(
				std::thread(
					MyProc,
					bmp.data,
					helper,
					(i == 0 ?
						bmp.row_padded :
						bmp.row_padded * ((bmp.height - 2) / (numberOfThreads - 1)) * i),
					bmp.row_padded * ((bmp.height - 2) / (numberOfThreads - 1)),
					bmp.row_padded
				)
			);
		}
		threads.push_back(
			std::thread(
				MyProc,
				bmp.data,
				helper,
				bmp.row_padded * ((bmp.height - 2) / (numberOfThreads)) * (numberOfThreads - 1),
				bmp.row_padded * (bmp.height - 2) - bmp.row_padded * ((bmp.height - 2) / (numberOfThreads)) * (numberOfThreads - 1),
				bmp.row_padded
			)
		);
		for (int i = 0; i < threads.size(); i++) {
			threads[i].join();
		}
	}

	bmp.saveAs(argv[2]);
	//bmp.saveAs("00.bmp");

	system("pause");
	return 0;
}