//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "LaplaceYoungDiffusion.h"

registerMooseObject("raccoonApp", LaplaceYoungDiffusion);

InputParameters
LaplaceYoungDiffusion::validParams()
{
  auto params = ADKernelGrad::validParams();
  params.addClassDescription("Diffusion term for Laplace Young equation "
                             "is computed using forward automatic differentiation");
  params.addParam<MaterialPropertyName>(
     "laplace_coeff", "_k", "The coefficent of Laplace Young $\\k$");
  return params;
}

LaplaceYoungDiffusion::LaplaceYoungDiffusion(const InputParameters & parameters) : ADKernelGrad(parameters)
 , _k(getADMaterialProperty<Real>("laplace_coeff"))

{}

ADRealVectorValue
LaplaceYoungDiffusion::precomputeQpResidual()
{
  ADReal k = 1./std::sqrt(1 + _grad_u[_qp] * _grad_u[_qp]);
  return _k[_qp] * _grad_u[_qp];
}
