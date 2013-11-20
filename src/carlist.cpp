#include "carlist.h"

std::vector<CarDescription> ReadCarList(std::string filename) {
	std::vector<CarDescription> cars_list;

	std::ifstream in(filename);

	int cars_count = 0;
	in >> cars_count;

	for (int i=0; i<cars_count; ++i) {
		cars_list.push_back(CarDescription());
		CarDescription& car = cars_list.back();

		in >> car.name;
		in >> car.color[0] >> car.color[1] >> car.color[2];
		in >> car.position[0] >> car.position[1] >> car.position[2];
		in >> car.orientation[0] >> car.orientation[1] >> car.orientation[2] >> car.orientation[3];
	}

	in.close();

	return cars_list;
}