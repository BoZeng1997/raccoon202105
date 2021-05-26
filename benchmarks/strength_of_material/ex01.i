[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 20
  ny = 1
  xmax = 10
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
[]

[Kernels]
  [./solid_x]
    type = ADStressDivergenceTensors
    variable = 'disp_x'
    component = 0
    displacements = 'disp_x disp_y'
  [../]
  [./solid_y]
    type = ADStressDivergenceTensors
    variable = 'disp_y'
    component = 1
    displacements = 'disp_x disp_y'
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ADComputeIsotropicElasticityTensor
    poissons_ratio = 0.2
    youngs_modulus = 4
  [../]
[]

[BCs]
  [./left_x] # arbitrary user-chosen name
    type = ADDirichletBC
    variable = disp_x
    boundary = 'left' # This must match a named boundary in the mesh file
    value = 0
  [../]
  [./right_x] # arbitrary user-chosen name
    type = ADNeumannBC
    variable = disp_x
    boundary = 'right' # This must match a named boundary in the mesh file
    value = 10
  [../]
  [./bottom_y] # arbitrary user-chosen name
    type = ADDirichletBC
    variable = disp_y
    boundary = 'bottom' # This must match a named boundary in the mesh file
    value = 0
  [../]
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'hypre'
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
[]
[Outputs]
  [csv_]
  type = CSV
  file_base = 1D_ela
  append_date = true
  #show = 'var_u'
  execute_vector_postprocessors_on = final
  []
[]
