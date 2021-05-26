#pragma once
#include <cstddef>
#include <cmath>
class _Node
{
public:
  _Node(unsigned int id, double x, double y) : _id(id), _x(x), _y(y) {};
  unsigned int id() {return _id;}
  double x() {return _x;}
  double y() {return _y;}
  double & d() {return _d;}
  double & Gc() {return _Gc;}
  double & E() {return _E;}

protected:
private:
  unsigned int _id;
  double _x;
  double _y;
  double _d;
  double _Gc;
  double _E;
};
