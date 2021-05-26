[MultiApps]
  [elastic]
    type = TransientMultiApp
    app_type = raccoonApp
    execute_on = timestep_begin
    input_files = linear_ela.i
  []
[]

[Transfers]
  [get_ela_energy]
    type = MultiAppCopyTransfer
    direction = from_multiapp
    multi_app = elastic
    source_variable = 'invar_1 invar_2 ela_energy ex_driving Gc L'
    variable = 'invar_1 invar_2 ela_energy ex_driving Gc L'
  []
  [send_d]
    type = MultiAppCopyTransfer
    multi_app = elastic
    direction = to_multiapp
    source_variable = 'd'
    variable = 'd'
  []
[]

[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 2
  ny = 2
  nz = 2
[]

[Problem]
  # solve = False
[]

[Variables]
  [d]
  []
[]

[AuxVariables]
  [invar_1]
    # order = CONSTANT
    # family = MONOMIAL
  []
  [invar_2]
    # order = CONSTANT
    # family = MONOMIAL
  []
  [ela_energy]
    order = CONSTANT
    family = MONOMIAL
  []
  [d_ref]
  []
  [ex_driving]
  []
  [Gc]
  []
  [L]
  []
[]

[Materials]
  # [kumar_material]
  #   type = DrukerPragerSurface
  #   output_properties = delta
  #   #outputs = CSV
  #   #tensile_strength =
  #   #compressive_strength =
  #   #delta =
  #   #alpha =
  # []
[]

[Kernels]
  # [ex_driving]
  #   type = ExternalDrivingForce
  #   variable = d
  #   first_invariant = invar_1
  #   second_invariant = invar_2
  #   elastic_energy = ela_energy
  # []
  # [diffusion]
  #   type = ADMatDiffusion
  #   diffusivity = diff_coef
  # []
  [d_ex_driving]
    type = MaterialPropertyValue
    variable = d
    prop_name = ex_driving
  []
[]

[Materials]
  [ex_driving_mat]
    type = ParsedMaterial
    f_name = 'ex_driving'
    args = 'ex_driving'
    function = 'ex_driving'
  []
  [energy_release_rates]
    type = GenericConstantMaterial
    prop_names = 'energy_release_rate'
    prop_values = 4
  []
  [length_scale]
    type = GenericConstantMaterial
    prop_names = 'phase_field_regularization_length'
    prop_values = '0.5'
  []
  [diff_coef]
    type = ADParsedMaterial
    f_name = 'diff_coef'
    # args = 'energy_release_rate phase_field_regularization_length'
    # function = 'energy_release_rate*phase_field_regularization_length'
    args = 'Gc L'
    function = 'Gc*L'
  []
[]


[BCs]

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

[VectorPostprocessors]
  [invar_2]
    type = NodalValueSampler
    variable = 'invar_2'
    sort_by = id
  []
  [ex_driving]
    type = NodalValueSampler
    variable = 'ex_driving'
    sort_by = id
  []
  [d]
    type = NodalValueSampler
    variable = 'd'
    sort_by = id
  []
[]

[Outputs]
  [csv_]
  type = CSV
  file_base = linear_frac
  append_date = true
  #show = 'var_u'
  execute_vector_postprocessors_on = timestep_end
  []
[]
