//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ExternalDrivingForce.h"

registerMooseObject("raccoonApp", ExternalDrivingForce);

InputParameters
ExternalDrivingForce::validParams()
{
  auto params = ADKernelValue::validParams();
  params.addClassDescription("Compute the Kumar external driving force plus"
                             "is not yet computed using forward automatic differentiation");
  //params.addParam<MaterialPropertyName>("")
   // params.addParam<MaterialPropertyName>(
   //     "first_invariant", "invar_1", "The first standard invariants of stress tensor");
   // params.addParam<MaterialPropertyName>(
   //     "second_invariant", "invar_2", "The second standard invariants of stress tensor");
  params.addCoupledVar("first_invariant","The first standard invariants of stress tensor");
  params.addCoupledVar("second_invariant","The second standard invariants of stress tensor");
  params.addCoupledVar("elastic_energy","The elastic energy from elastic module");
  return params;
}

ExternalDrivingForce::ExternalDrivingForce(const InputParameters & parameters) :
ADKernelValue(parameters)
,_beta_0(getMaterialProperty<Real>("beta_0"))
,_beta_1(getMaterialProperty<Real>("beta_1"))
,_beta_2(getMaterialProperty<Real>("beta_2"))
,_beta_3(getMaterialProperty<Real>("beta_3"))
// ,_invar_1(coupledValue(getParam<MaterialPropertyName>("first_invariant")))
// ,_invar_2(coupledValue(getParam<MaterialPropertyName>("second_invariant")))
,_invar_1(adCoupledValue("first_invariant"))
,_invar_2(adCoupledValue("second_invariant"))
,_ela_energy(adCoupledValue("elastic_energy"))
,_Gc(getParam<Real>("energy_release_rate"))
,_L(getParam<Real>("phase_field_regularization_length"))

{}

ADReal
ExternalDrivingForce::precomputeQpResidual()
{
  //(_beta_2*std::sqrt(_invar_2)+_beta_1*_invar_1+_beta_0)/(1+_beta_3*_invar_1^2)
 // Real _kappa = 1;
 //  return _kappa * _u[_qp];
//  Real ce = (_beta_2[_qp]*std::sqrt(_invar_2)
//             +_beta_1[_qp]*_invar_1+_beta_0[_qp])/(1+_beta_3[_qp]*_invar_1*_invar_1);
// return ce*4.0/3.0-_Gc/2.0/_L;
ADReal ce = (_beta_2[_qp]*std::sqrt(_invar_2[_qp])
           +_beta_1[_qp]*_invar_1[_qp]+_beta_0[_qp])/(1.0+_beta_3[_qp]*_invar_1[_qp]*_invar_1[_qp]);
// _ex_driving[_qp]= ce*4.0/3.0-_Gc/2.0/_L;
return (_u[_qp]-1)*_ela_energy[_qp]+ce*4.0/3.0-_Gc/2.0/_L;
 // return _u[_qp];
}
