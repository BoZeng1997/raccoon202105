[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 2
  ny = 2
  nz = 2
[]

[Problem]
  solve = False
[]


[Variables]
  [invar_1]
  []
  [invar_2]
  []
[]

[Materials]
  [kumar_material]
    type = DrukerPragerSurface
    output_properties = delta
    #outputs = CSV
    #tensile_strength =
    #compressive_strength =
    #delta =
    #alpha =
  []
[]

[Kernels]
  [ex_driving]
    type = ExternalDrivingForce
    variable = invar_1
  []
[]

# [AuxKernels]
#   [./invar_1]
#   type = ADRankTwoScalarAux
#   rank_two_tensor = stress
#   variable = invar_1
#   scalar_type = firstinvariant
#   [../]
#   [./invar_2]
#   type = ADRankTwoScalarAux
#   rank_two_tensor = stress
#   variable = invar_2
#   scalar_type = secondinvariant
#   [../]
# []


[Executioner]
  type = Transient
  dt = 0.05
  solve_type = 'NEWTON'

  petsc_options_iname = -pc_hypre_type
  petsc_options_value = boomeramg

  dtmin = 0.05
  num_steps = 1
[]

# [VectorPostprocessors]
#   [disp_x]
#     type = NodalValueSampler
#     variable = 'disp_x'
#     sort_by = id
#     []
#   [invar_1]
#     type = NodalValueSampler
#     variable = 'invar_1'
#     sort_by = id
#   []
#   [invar_2]
#     type = NodalValueSampler
#     variable = 'invar_2'
#     sort_by = id
#   []
# []

[Outputs]
  [csv_]
  type = CSV
  file_base = linear_ce
  append_date = true
  #show = 'var_u'
  execute_vector_postprocessors_on = final
  []
[]
