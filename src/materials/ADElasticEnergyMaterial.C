//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ADElasticEnergyMaterial.h"
#include "RankTwoTensor.h"
#include "RankFourTensor.h"

registerMooseObject("raccoonApp", ADElasticEnergyMaterial);

InputParameters
ADElasticEnergyMaterial::validParams()
{
  InputParameters params = ADMaterial::validParams();
  params.addClassDescription("Free energy material for the AD elastic energy contributions.");
  params.addParam<std::string>("base_name", "Material property base name");
  // params.addRequiredCoupledVar("args", "Arguments of F() - use vector coupling");
  // params.addCoupledVar("displacement_gradients",
  //                      "Vector of displacement gradient variables (see "
  //                      "Modules/PhaseField/DisplacementGradients "
  //                      "action)");
  return params;
}

ADElasticEnergyMaterial::ADElasticEnergyMaterial(const InputParameters & parameters)
  : ADMaterial(parameters),
    _base_name(isParamValid("base_name") ? getParam<std::string>("base_name") + "_" : ""),
    _stress(getADMaterialPropertyByName<RankTwoTensor>(_base_name + "stress")),
    _elasticity_tensor(getADMaterialPropertyByName<RankFourTensor>(_base_name + "elasticity_tensor")),
    _strain(getADMaterialPropertyByName<RankTwoTensor>(_base_name + "elastic_strain"))
    ,_elastic_energy(declareADProperty<Real>("elastic_energy"))
{
  // _dstrain.resize(_nargs);
  // _d2strain.resize(_nargs);
  // _delasticity_tensor.resize(_nargs);
  // _d2elasticity_tensor.resize(_nargs);

  // fetch stress and elasticity tensor derivatives (in simple eigenstrain models this is is only
  // w.r.t. 'c')
  // for (unsigned int i = 0; i < _nargs; ++i)
  // {
  //   _dstrain[i] = &getMaterialPropertyDerivativeByName<RankTwoTensor>(_base_name + "elastic_strain",
  //                                                                     _arg_names[i]);
  //   _delasticity_tensor[i] = &getMaterialPropertyDerivativeByName<RankFourTensor>(
  //       _base_name + "elasticity_tensor", _arg_names[i]);
  //
  //   _d2strain[i].resize(_nargs);
  //   _d2elasticity_tensor[i].resize(_nargs);
  //
  //   for (unsigned int j = 0; j < _nargs; ++j)
  //   {
  //     _d2strain[i][j] = &getMaterialPropertyDerivativeByName<RankTwoTensor>(
  //         _base_name + "elastic_strain", _arg_names[i], _arg_names[j]);
  //     _d2elasticity_tensor[i][j] = &getMaterialPropertyDerivativeByName<RankFourTensor>(
  //         _base_name + "elasticity_tensor", _arg_names[i], _arg_names[j]);
  //   }
  // }
}

// void
// ADElasticEnergyMaterial::initialSetup()
// {
//   validateCoupling<RankTwoTensor>(_base_name + "elastic_strain");
//   validateCoupling<RankFourTensor>(_base_name + "elasticity_tensor");
// }

void
ADElasticEnergyMaterial::computeQpProperties()
{
  _elastic_energy[_qp] = 0.5 * _stress[_qp].doubleContraction(_strain[_qp]);
}

// Real
// ADElasticEnergyMaterial::computeDF(unsigned int i_var)
// {
//   unsigned int i = argIndex(i_var);
//
//   // product rule d/di computeF (doubleContraction commutes)
//   return 0.5 * ((*_delasticity_tensor[i])[_qp] * _strain[_qp]).doubleContraction(_strain[_qp]) +
//          (_elasticity_tensor[_qp] * (*_dstrain[i])[_qp]).doubleContraction(_strain[_qp]);
// }

// Real
// ADElasticEnergyMaterial::computeD2F(unsigned int i_var, unsigned int j_var)
// {
//   unsigned int i = argIndex(i_var);
//   unsigned int j = argIndex(j_var);
//
//   // product rule d/dj computeDF
//   // TODO: simplify because doubleContraction commutes
//   return 0.5 * (((*_d2elasticity_tensor[i][j])[_qp] * _strain[_qp] +
//                  (*_delasticity_tensor[i])[_qp] * (*_dstrain[j])[_qp] +
//                  (*_delasticity_tensor[j])[_qp] * (*_dstrain[i])[_qp] +
//                  _elasticity_tensor[_qp] * (*_d2strain[i][j])[_qp])
//                     .doubleContraction(_strain[_qp]) +
//                 ((*_delasticity_tensor[i])[_qp] * _strain[_qp] +
//                  _elasticity_tensor[_qp] * (*_dstrain[i])[_qp])
//                     .doubleContraction((*_dstrain[j])[_qp])
//
//                 + ( // dstress/dj
//                       (*_delasticity_tensor[j])[_qp] * _strain[_qp] +
//                       _elasticity_tensor[_qp] * (*_dstrain[j])[_qp])
//                       .doubleContraction((*_dstrain[i])[_qp]) +
//                 _stress[_qp].doubleContraction((*_d2strain[i][j])[_qp]));
// }
