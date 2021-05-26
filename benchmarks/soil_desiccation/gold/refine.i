[Problem]
  type = FEProblem
  solve = false
[]

[Mesh]
  type = FileMesh
  file = %s
  uniform_refine = 4
[]

[AuxVariables]
  [Gc]
    initial_from_file_var = 'Gc'
  []
  [E]
    initial_from_file_var = 'E'
  []
[]

[Executioner]
  type = Steady
[]

[Outputs]
  exodus = true
  file_base = %s
[]
