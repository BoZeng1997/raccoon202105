[MultiApps]
  [mechanical]
    type = TransientMultiApp
    input_files = 'GE_mechanical.i'
    app_type = raccoonApp
    execute_on = 'TIMESTEP_END'
  []
[]

[Transfers]
  [get_E_el_active]
    type = MultiAppCopyTransfer
    multi_app = 'mechanical'
    direction = from_multiapp
    source_variable = 'E_el_active'
    variable = 'E_el_active'
  []
  [send_load]
    type = MultiAppScalarToAuxScalarTransfer
    multi_app = 'mechanical'
    direction = to_multiapp
    source_variable = 'load'
    to_aux_scalar = 'load'
  []
  [send_d]
    type = MultiAppCopyTransfer
    multi_app = 'mechanical'
    direction = to_multiapp
    source_variable = 'd'
    variable = 'd'
  []
[]

[Mesh]
  type = FileMesh
  file = '../gold/fields_1D_PE_L10P100_Gc_E_r0_N50_cluster_set97848.e'
[]

[Variables]
  [d]
  []
[]

[AuxVariables]
  [load]
    family = SCALAR
  []
  [E_el_active]
    order = CONSTANT
    family = MONOMIAL
  []
  [d_ref]
  []
  [bounds_dummy]
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

[BCs]
  [Periodic]
    [left_right]
      variable = 'd'
      primary = 'left'
      secondary = 'right'
      translation = '100 0 0'
    []
  []
[]

[Bounds]
  [irreversibility]
    type = CoupledBoundsAux
    variable = 'bounds_dummy'
    bounded_variable = 'd'
    bound_type = lower
    coupled_variable = 'd_ref'
  []
  [upper]
    type = ConstantBoundsAux
    variable = 'bounds_dummy'
    bounded_variable = 'd'
    bound_type = upper
    bound_value = 1
  []
[]



[Kernels]
  [pff_diff]
    type = ADPFFDiffusion
    variable = 'd'
  []
  [pff_barr]
    type = ADPFFBarrier
    variable = 'd'
  []
  [pff_react]
    type = ADPFFReaction
    variable = 'd'
    driving_energy_var = 'E_el_active'
  []
[]

[Materials]
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
  type = TransientSubcycling
  solve_type = 'NEWTON'
  petsc_options_iname = '-pc_type -snes_type'
  petsc_options_value = 'lu vinewtonrsls'
  dt = 1e-4

  nl_abs_tol = 1e-06
  nl_rel_tol = 1e-06
[]

[Outputs]
  # hide = 'load'
  # print_linear_residuals = false
  console = false
[]
