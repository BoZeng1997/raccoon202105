[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 20
  ny = 20
[]

[Variables]
  [u]
  []
[]

[Kernels]
  [diffusion]#name whatever you want
    type = LaplaceYoungDiffusion #a class already defined
    variable = u #the var to be excute on

  []
  [source]
    type = LaplaceYoungSource
    variable = u
    kappa = 0.9 #addParam
  []
[]

[Materials]
  [laplace_coeff]
    type = ADParsedMaterial
    f_name = _k
    args = '_grad_u'
    function = '1./sqrt(1 + _grad_u * _grad_u)'
    outputs = exodus
  [../]
[]

[BCs]
  [all]
    type = ADNeumannBC
    variable = u
    value = 0.2
    boundary = "left right top bottom"
  []
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'hypre'
[]

[VectorPostprocessors]
  [var_u]
    type = NodalValueSampler
    variable = 'u'
    sort_by = id
  []
[]
[Outputs]
  [csv_]
  type = CSV
  file_base = out
  append_date = true
  show = 'var_u'
  execute_vector_postprocessors_on = final
  []
[]
