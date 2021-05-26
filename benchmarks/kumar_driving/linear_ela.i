[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 20
  ny = 20
  nz = 20
[]

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
  [./disp_z]
  [../]
[]

[AuxVariables]
  [invar_1]
  []
  [invar_2]
  []
  [ex_driving_]
    # order = CONSTANT
    # family = MONOMIAL
  []
  [d]
  []
  [ela_energy]
    order = CONSTANT
    family = MONOMIAL
  []
  [Gc]
  []
  [L]
  []
[]

[AuxKernels]
  [./invar_1]
  type = ADRankTwoScalarAux
  rank_two_tensor = stress
  variable = invar_1
  scalar_type = firstinvariant
  [../]
  [./invar_2]
  type = ADRankTwoScalarAux
  rank_two_tensor = stress
  variable = invar_2
  scalar_type = secondinvariant
  [../]
  [ela_energy]
    type = ADMaterialRealAux
    variable = 'ela_energy'
    property = 'elastic_energy'
    execute_on = 'TIMESTEP_END'
  []
  [E_driving]
    type = ADMaterialRealAux
    variable = 'ex_driving_'
    property = 'ex_driving'
    execute_on = 'TIMESTEP_END'
  []
[]

[Kernels]
  [./stress_x]
    type = ADCoefStressDivergenceTensors
    component = 0
    variable = disp_x
    displacements = 'disp_x disp_y disp_z'
    d = 'd'
  [../]
  [./stress_y]
    type = ADCoefStressDivergenceTensors
    component = 1
    variable = disp_y
    displacements = 'disp_x disp_y disp_z'
    d = 'd'
  [../]
  [./stress_z]
    type = ADCoefStressDivergenceTensors
    component = 2
    variable = disp_z
    displacements = 'disp_x disp_y disp_z'
    d = 'd'
  [../]
[]



[BCs]
  [./symmy]
    type = DirichletBC
    variable = disp_y
    boundary = bottom
    value = 0
  [../]
  [./udisp]
    type = DirichletBC
    variable = disp_y
    boundary = top
    value = 0.2
  [../]
  [./symmx]
    type = DirichletBC
    variable = disp_x
    boundary = left
    value = 0
  [../]
  [./rdisp]
    type = DirichletBC
    variable = disp_x
    boundary = right
    value = 0.1
  [../]
  [./symmz]
    type = DirichletBC
    variable = disp_z
    boundary = back
    value = 0
  [../]
  [./tdisp]
    type = DirichletBC
    variable = disp_z
    boundary = front
    value = 0.3
  [../]
[]



[Materials]
  [./elasticity]
    type = ADComputeIsotropicElasticityTensor
    poissons_ratio = 0.3
    youngs_modulus = 10
  [../]
  [./strain]
    type = ADComputeSmallStrain
  [../]
  [./stress]
    type = ADComputeLinearElasticStress
  [../]
  [energy_release_rates]
    type = GenericConstantMaterial
    prop_names = 'energy_release_rate'
    prop_values = 4
  []
  [critial_fracture_energy]
    type = GenericConstantMaterial
    prop_names = 'critical_fracture_energy'
    prop_values = 3e-5
  []
  [length_scale]
    type = GenericConstantMaterial
    prop_names = 'phase_field_regularization_length'
    prop_values = '0.5'
  []
  [fracture_properties]
    type = FractureMaterial
    local_dissipation_norm = 8/3
    constant_in_time = false
  []
  [elastic_energy]
    type = ADElasticEnergyMaterial
  []
  [kumar_material]
    type = DrukerPragerSurface
    output_properties = delta
    first_invariant = invar_1
    second_invariant = invar_2
    #outputs = CSV
    tensile_strength = 27
    compressive_strength = 77
    delta = 1
    alpha = 1
  []
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'
  petsc_options_iname = '-pc_type -sub_pc_type -ksp_max_it -ksp_gmres_restart -sub_pc_factor_levels'
  petsc_options_value = 'asm      ilu          200         200                0                    '
  dt = 1e-2

  nl_abs_tol = 1e-10
  nl_rel_tol = 1e-06
[]

[VectorPostprocessors]
  [disp_x]
    type = NodalValueSampler
    variable = 'disp_x'
    sort_by = id
  []
  [disp_y]
    type = NodalValueSampler
    variable = 'disp_y'
    sort_by = id
  []
  [disp_z]
    type = NodalValueSampler
    variable = 'disp_z'
    sort_by = id
  []
  [invar_1]
    type = NodalValueSampler
    variable = 'invar_1'
    sort_by = id
  []
  [invar_2]
    type = NodalValueSampler
    variable = 'invar_2'
    sort_by = id
  []
[]

[Outputs]
  [csv_]
  type = CSV
  file_base = linear_ela
  append_date = true
  #show = 'var_u'
  execute_vector_postprocessors_on = final
  []
[]
