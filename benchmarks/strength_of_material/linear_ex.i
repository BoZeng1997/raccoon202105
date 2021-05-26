[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 2
  ny = 2
  nz = 2
[]

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Variables]
  # scale with one over Young's modulus
  [./disp_x]
    #scaling = 1e-10
  [../]
  [./disp_y]
    #scaling = 1e-10
  [../]
  [./disp_z]
    #scaling = 1e-10
  [../]
[]

[AuxVariables]
  [Gc]
  []
  [sigma_00]
  []
  [invar_1]
  []
  [invar_2]
  []
  [invar_3]
  []
[]

[Kernels]
  [./stress_x]
    type = ADStressDivergenceTensors
    component = 0
    variable = disp_x
  [../]
  [./stress_y]
    type = ADStressDivergenceTensors
    component = 1
    variable = disp_y
  [../]
  [./stress_z]
    type = ADStressDivergenceTensors
    component = 2
    variable = disp_z
  [../]
[]

[AuxKernels]
  [./stress_xx]
    type = ADRankTwoAux
    rank_two_tensor = stress
    variable = sigma_00
    index_i = 0
    index_j = 0
  [../]
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
  [./invar_3]
  type = ADRankTwoScalarAux
  rank_two_tensor = stress
  variable = invar_3
  scalar_type = thirdinvariant
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
    youngs_modulus = youngs_modulus
  [../]
  [./strain]
    type = ADComputeSmallStrain
  [../]
  [./stress]
    type = ADComputeLinearElasticStress
  [../]
  [energy_release_rate]
    type = ADParsedMaterial
    f_name = 'energy_release_rate'
    #args = 'Gc'
    function = '4'
  []
  [_youngs_modulus]
    type = ADParsedMaterial
    f_name = 'youngs_modulus'
    #args = 'E'
    function = '10'
    #outputs = exodus
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
  # [_RankTwoCartesianComponent]
  #   type = ADRankTwoCartesianComponent
  #   index_i = 0
  #   index_j = 0
  #   property_name = sigma_00
  #   rank_two_tensor = stress
  # []
  # [invariant_1]
  #   type = ADRankTwoInvariant
  #   property_name = invar_1
  #   rank_two_tensor = stress
  #   invariant = FirstInvariant
  #   output_properties = invar_1
  #   output = CSV
  # []
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  dt = 0.05
  solve_type = 'NEWTON'

  petsc_options_iname = -pc_hypre_type
  petsc_options_value = boomeramg

  dtmin = 0.05
  num_steps = 1
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
  [sigma_00]
    type = NodalValueSampler
    variable = 'sigma_00'
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
  [invar_3]
    type = NodalValueSampler
    variable = 'invar_3'
    sort_by = id
  []
[]

[Outputs]
  [csv_]
  type = CSV
  file_base = linear_ex
  append_date = true
  #show = 'var_u'
  execute_vector_postprocessors_on = final
  []
[]
