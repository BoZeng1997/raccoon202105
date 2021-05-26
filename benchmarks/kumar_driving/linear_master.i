[Problem]
  solve = false
[]

[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 20
  ny = 20
  nz = 20
[]

[MultiApps]
  [fracture]
    type = TransientMultiApp
    app_type = raccoonApp
    execute_on = 'TIMESTEP_END'
    sub_cycling = true
    detect_steady_state = true
    steady_state_tol = 0.1
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
  dt = 1e-1
  # end_time = 1
  # dt = 0.05
  # solve_type = 'NEWTON'
  #
  # petsc_options_iname = -pc_hypre_type
  # petsc_options_value = boomeramg
  #
  # dtmin = 0.05
  num_steps = 1
[]

[Outputs]
  [csv_]
  type = CSV
  file_base = linear_mas
  append_date = true
  execute_vector_postprocessors_on = final
  []
[]
