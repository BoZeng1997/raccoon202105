[Problem]
  solve = false
[]

[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 2
  ny = 2
  nz = 2
[]

[MultiApps]
  [fracture]
    type = TransientMultiApp
    app_type = raccoonApp
    execute_on = 'TIMESTEP_END'
    input_files = linear_fracture.i
  []
[]

[Transfers]
  [get_d_ref]
    type = MultiAppMeshFunctionTransfer
    multi_app = fracture
    direction = from_multiapp
    source_variable = 'd'
    variable = 'd'
    execute_on = 'TIMESTEP_END'
  []
  [send_d_ref]
    type = MultiAppMeshFunctionTransfer
    multi_app = fracture
    direction = to_multiapp
    source_variable = 'd'
    variable = 'd_ref'
    execute_on = 'TIMESTEP_BEGIN'
  []
[]

[AuxVariables]
  [d]
  []
[]

[Executioner]
  type = Transient
  dt = 0.05
  solve_type = 'NEWTON'

  petsc_options_iname = -pc_hypre_type
  petsc_options_value = boomeramg

  dtmin = 0.05
  num_steps = 10
[]

[Outputs]
  [csv_]
  type = CSV
  file_base = linear_mas
  append_date = true
  execute_vector_postprocessors_on = final
  []
[]
