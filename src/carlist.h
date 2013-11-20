#pragma once

#include <string>
#include <vector>
#include <fstream>

#include "mathvector.h"
#include "quaternion.h"

struct CarDescription {
	std::string				name;
	MATHVECTOR<float,3>		color;
	MATHVECTOR<float,3>		position;
	QUATERNION<float>		orientation;
};

std::vector<CarDescription> ReadCarList(std::string filename);