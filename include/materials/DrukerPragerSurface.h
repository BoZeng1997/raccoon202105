//* This file is part of the RACCOON application
//* being developed at Dolbow lab at Duke University
//* http://dolbow.pratt.duke.edu

#pragma once

#include "ADMaterial.h"

class DrukerPragerSurface : public ADMaterial
{
public:
  static InputParameters validParams();

  DrukerPragerSurface(const InputParameters & parameters);

protected:
  virtual void computeQpProperties() override;

  const MaterialPropertyName _ex_driving_name;

  ADMaterialProperty<Real> & _ex_driving;

  /// energy release rate
  //const GenericMaterialProperty<Real,true> & _Gc;
  //const MaterialProperty<Real> & _Gc;
  const Real & _Gc;

  /// phase field regularization length
  //const MaterialProperty<Real> & _L;
  const Real & _L;

  /// tensile strength
  const Real & _sigma_ts;

  /// compressive strength
  const Real & _sigma_cs;

  ///
  const Real & _delta;

  ///
  const Real & _alpha;

  ///
  MaterialProperty<Real> & _beta_0;
  // Real & _beta_0;
  MaterialProperty<Real> & _beta_1;
  MaterialProperty<Real> & _beta_2;
  MaterialProperty<Real> & _beta_3;
  Real _gamma_0;
  Real _gamma_1;
  const ADVariableValue & _invar_1;
  const ADVariableValue & _invar_2;
};
