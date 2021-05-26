[Problem]
  solve = false
[]

[Mesh]
  type = FileMesh
  file = '../gold/fields_1D_PE_L10P100_Gc_E_r0_N50_cluster_set94728.e'
[]

[MultiApps]
  [fracture]
    type = TransientMultiApp
    input_files = 'GE_fracture.i'
    app_type = raccoonApp
    execute_on = 'TIMESTEP_END'
    sub_cycling = true
    detect_steady_state = true
    steady_state_tol = 0.1
  []
[]

[Transfers]
  [send_load]
    type = MultiAppScalarToAuxScalarTransfer
    multi_app = fracture
    direction = to_multiapp
    source_variable = 'load'
    to_aux_scalar = 'load'
  []
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
  [load]
    family = SCALAR
  []
  [d]
  []
  [Gc]
    initial_from_file_var = 'Gc'
  []
  [E]
    initial_from_file_var = 'E'
  []
[]

[AuxScalarKernels]
  [load]
    type = FunctionScalarAux
    variable = load
    function = t
    execute_on = 'TIMESTEP_BEGIN'
  []
[]

[Executioner]
  type = Transient
  dt = 1e-3
  end_time = 0.1
[]

[Outputs]
  [./exodus]
    type = Exodus
    # append_date = true
    file_base = '1D_PE_L10P100_Gc_E_r0_N50_cluster_set94728'
  [../]
  console = false
[]
