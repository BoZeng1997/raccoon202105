//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

// #include "DerivativeFunctionMaterialBase.h"
#include "ADRankTwoTensorForward.h"
#include "ADRankFourTensorForward.h"
#include "ADMaterial.h"

/**
 * Material class to compute the elastic free energy and its derivatives
 */
class ADElasticEnergyMaterial : public ADMaterial
{
public:
  static InputParameters validParams();

  ADElasticEnergyMaterial(const InputParameters & parameters);

  // virtual void initialSetup() override;

protected:
  virtual void computeQpProperties() override;
  // virtual Real computeDF(unsigned int i_var) override;
  // virtual Real computeD2F(unsigned int i_var, unsigned int j_var) override;

  const std::string _base_name;

  /// Stress tensor
  const ADMaterialProperty<RankTwoTensor> & _stress;
  // std::vector<const MaterialProperty<RankTwoTensor> *> _dstress;
  // std::vector<std::vector<const MaterialProperty<RankTwoTensor> *> > _d2stress;

  ///@{ Elasticity tensor derivatives
  const ADMaterialProperty<RankFourTensor> & _elasticity_tensor;
  // std::vector<const MaterialProperty<RankFourTensor> *> _delasticity_tensor;
  // std::vector<std::vector<const MaterialProperty<RankFourTensor> *>> _d2elasticity_tensor;
  ///@}

  ///@{ Strain and derivatives
  const ADMaterialProperty<RankTwoTensor> & _strain;
  // std::vector<const MaterialProperty<RankTwoTensor> *> _dstrain;
  // std::vector<std::vector<const MaterialProperty<RankTwoTensor> *>> _d2strain;
  ///@}

  /// positive elastic driving energy
  ADMaterialProperty<Real> & _elastic_energy;
};
