#ifndef _CAMERA_FREE_H
#define _CAMERA_FREE_H

#include "camera.h"

class CAMERA_FREE : public CAMERA
{
public:
	CAMERA_FREE(const std::string & name);

	void SetOffset(const MATHVECTOR <float, 3> & value);

	void Reset(const MATHVECTOR <float, 3> & newpos, const QUATERNION <float> & newquat);

	void Rotate(float up, float left);

	void Move(float dx, float dy, float dz);

	virtual bool Serialize(joeserialize::Serializer & s);

private:
	MATHVECTOR <float, 3> offset;
	float leftright_rotation;
	float updown_rotation;
};

#endif // _CAMERA_FREE_H
