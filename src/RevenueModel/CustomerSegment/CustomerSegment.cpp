#include "CustomerSegment.h"

CustomerSegment::CustomerSegment()
{
	this->id = 0;
	this->customerSegmentName = "";
}


CustomerSegment::CustomerSegment(std::string name)
{
	this->id = 0;
	this->customerSegmentName = name;
}


CustomerSegment::~CustomerSegment()
{
	this->id = 0;
}