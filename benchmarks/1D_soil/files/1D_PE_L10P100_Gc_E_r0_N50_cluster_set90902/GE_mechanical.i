[Mesh]
  type = FileMesh
  file = '../gold/fields_1D_PE_L10P100_Gc_E_r0_N50_cluster_set90902.e'
[]

[Variables]
  [disp_x]
  []
  [disp_y]
  []
  [strain_zz]
  []
[]

[AuxVariables]
  [d]
  []
  [load]
    family = SCALAR
  []
  [zero]
    family = SCALAR
  []
  [E_el_active]
    order = CONSTANT
    family = MONOMIAL
  []
  [Gc]
    initial_from_file_var = 'Gc'
  []
  [E]
    initial_from_file_var = 'E'
  []
  [psic]
  []

[]

[AuxKernels]
  [E_driving]
    type = ADMaterialRealAux
    variable = 'E_el_active'
    property = 'E_el_active'
    execute_on = 'TIMESTEP_END'
  []
[]

[Kernels]
  [solid_x]
    type = ADStressDivergenceTensors
    variable = 'disp_x'
    component = 0
    displacements = 'disp_x disp_y'
  []
  [solid_y]
    type = ADStressDivergenceTensors
    variable = 'disp_y'
    component = 1
    displacements = 'disp_x disp_y'
  []
  [plane_stress]
    type = ADWeakPlaneStress
    variable = 'strain_zz'
    displacements = 'disp_x disp_y'
  []
  [react_x]
    type = ADCoefMatReaction
    variable = 'disp_x'
    coefficient = 0.1
    prop_names = 'g'
  []
  [react_y]
    type = ADCoefMatReaction
    variable = 'disp_y'
    coefficient = 0.1
    prop_names = 'g'
  []
[]

[BCs]
  [Periodic]
    [x_left_right]
      variable = disp_x
      primary = 'left'
      secondary = 'right'
      translation = '100 0 0'
    []
    [y_left_right]
      variable = disp_y
      primary = 'left'
      secondary = 'right'
      translation = '100 0 0'
    []
  []
[]

[Materials]
  [eigen_strain]
    type = ADComputeEigenstrainFromScalarEigenstress
    eigen_stress = 'load zero zero zero load zero zero zero zero'
    eigenstrain_name = 'is'
  []
  [elasticity_tensor]
    type = ADComputeVariableIsotropicElasticityTensor
    poissons_ratio = 0.2
    youngs_modulus = 'youngs_modulus'
  []
  [strain]
    type = ADComputePlaneSmallStrain
    out_of_plane_strain = 'strain_zz'
    eigenstrain_names = 'is'
    displacements = 'disp_x disp_y'
  []
  [stress]
    type = SmallStrainDegradedElasticPK2Stress_NoSplit
    d = 'd'
    d_crit = 0.6
  []
  [energy_release_rate]
    type = ADParsedMaterial
    f_name = 'energy_release_rate'
    args = 'Gc'
    function = 'Gc'
  []
  [critial_fracture_energy]
    type = ADParsedMaterial
    f_name = 'critical_fracture_energy'
    #args = 'psic'
    function = '3e-5'
  []
  [./youngs_modulus]
    type = ADParsedMaterial
    f_name = 'youngs_modulus'
    args = 'E'
    function = 'E'
    #outputs = exodus
  [../]
  [length_scale]
    type = ADGenericConstantMaterial
    prop_names = 'phase_field_regularization_length'
    prop_values = '0.5'
  []
  [local_dissipation]
    type = LinearLocalDissipation
    d = 'd'
  []
  [fracture_properties]
    type = ADFractureMaterial
    local_dissipation_norm = 8/3
    constant_in_time = false
  []
  [degradation]
    type = LorentzDegradation
    d = 'd'
    residual_degradation = 1e-06
  []
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'
  petsc_options_iname = '-pc_type -sub_pc_type -ksp_max_it -ksp_gmres_restart -sub_pc_factor_levels'
  petsc_options_value = 'asm      ilu          200         200                0                    '
  dt = 1e-4

  nl_abs_tol = 1e-10
  nl_rel_tol = 1e-06

  # automatic_scaling = true
[]

[Outputs]
  # hide = 'load'
  # print_linear_residuals = false
  console = false
[]
