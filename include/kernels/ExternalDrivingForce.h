//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ADKernelValue.h"

class ExternalDrivingForce : public ADKernelValue
{
public:
  static InputParameters validParams();

  ExternalDrivingForce(const InputParameters & parameters);

protected:
  virtual ADReal precomputeQpResidual() override;
  // const MaterialProperty<Real> & _beta_0;
  const MaterialProperty<Real> & _beta_0;
  const MaterialProperty<Real> & _beta_1;
  const MaterialProperty<Real> & _beta_2;
  const MaterialProperty<Real> & _beta_3;
  const ADVariableValue & _invar_1;
  const ADVariableValue & _invar_2;
  const ADVariableValue & _ela_energy;
  /// energy release rate
  //const GenericMaterialProperty<Real,true> & _Gc;
  //const MaterialProperty<Real> & _Gc;
  const Real & _Gc;

  /// phase field regularization length
  //const MaterialProperty<Real> & _L;
  const Real & _L;
};
