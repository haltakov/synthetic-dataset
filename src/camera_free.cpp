#include "camera_free.h"
#include "coordinatesystem.h"
#include "macros.h"

CAMERA_FREE::CAMERA_FREE(const std::string & name) :
	CAMERA(name),
	offset(direction::Up * 2 - direction::Forward * 8),
	leftright_rotation(0),
	updown_rotation(0)
{
	rotation.LoadIdentity();
}

void CAMERA_FREE::SetOffset(const MATHVECTOR <float, 3> & value)
{
	offset = value;
	if (offset.dot(direction::Forward) < 0.001)
	{
		offset = offset - direction::Forward;
	}
}

void CAMERA_FREE::Reset(const MATHVECTOR <float, 3> & newpos, const QUATERNION <float> & newquat)
{
	leftright_rotation = 0;
	updown_rotation = 0;
	rotation = newquat;
	position = newpos + offset;
}

void CAMERA_FREE::Rotate(float up, float left)
{
	updown_rotation += up;
	if (updown_rotation > 1.0) updown_rotation = 1.0;
	if (updown_rotation <-1.0) updown_rotation =-1.0;
	leftright_rotation += left;

	rotation.LoadIdentity();
	rotation.Rotate(updown_rotation, direction::Right);
	rotation.Rotate(leftright_rotation, direction::Up);
}

void CAMERA_FREE::Move(float dx, float dy, float dz)
{
	MATHVECTOR <float, 3> move(dx, dy, dz);
	MATHVECTOR <float, 3> forward = direction::Forward * direction::Forward.dot(move);
	rotation.RotateVector(forward);
	position = position + forward;
}

bool CAMERA_FREE::Serialize(joeserialize::Serializer & s)
{
	_SERIALIZE_(s,position);
	_SERIALIZE_(s,leftright_rotation);
	_SERIALIZE_(s,updown_rotation);

	return true;
}
