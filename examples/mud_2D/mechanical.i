[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Mesh]
  type = FileMesh
  file = 'gold/geo.msh'
[]

[MultiApps]
  [./fracture]
    type = TransientMultiApp
    input_files = 'fracture.i'
    app_type = raccoonApp
    execute_on = 'TIMESTEP_END'
  [../]
[]

[Transfers]
  [./disp_x]
    type = MultiAppCopyTransfer
    multi_app = fracture
    direction = to_multiapp
    source_variable = 'disp_x'
    variable = 'disp_x'
    execute_on = SAME_AS_MULTIAPP
  [../]
  [./disp_y]
    type = MultiAppCopyTransfer
    multi_app = fracture
    direction = to_multiapp
    source_variable = 'disp_y'
    variable = 'disp_y'
    execute_on = SAME_AS_MULTIAPP
  [../]
  [./strain_zz]
    type = MultiAppCopyTransfer
    multi_app = fracture
    direction = to_multiapp
    source_variable = 'strain_zz'
    variable = 'strain_zz'
    execute_on = SAME_AS_MULTIAPP
  [../]
  [./d_ref]
    type = MultiAppCopyTransfer
    multi_app = fracture
    direction = to_multiapp
    source_variable = 'd_ref'
    variable = 'd_ref'
    execute_on = SAME_AS_MULTIAPP
  [../]
  [./d]
    type = MultiAppCopyTransfer
    multi_app = fracture
    direction = from_multiapp
    source_variable = 'd'
    variable = 'd'
    execute_on = SAME_AS_MULTIAPP
  [../]
  [./load]
    type = MultiAppScalarToAuxScalarTransfer
    multi_app = fracture
    direction = to_multiapp
    source_variable = 'load'
    to_aux_scalar = 'load'
    execute_on = SAME_AS_MULTIAPP
  [../]
[]

[Modules]
  [./KLExpansion]
    [./E_crit]
      file_name = 'gold/kl_info.txt'
      field_distribution = GAMMA
      perturbation = CUSTOM
      custom_Gaussian_weights = '0.537667139546100 1.83388501459509 -2.25884686100365 0.862173320368121 0.318765239858981 -1.30768829630527 -0.433592022305684 0.342624466538650 3.57839693972576 2.76943702988488 -1.34988694015652 3.03492346633185 0.725404224946106 -0.0630548731896562 0.714742903826096 -0.204966058299775 -0.124144348216312 1.48969760778547 1.40903448980048 1.41719241342961 0.671497133608081 -1.20748692268504 0.717238651328839 1.63023528916473 0.488893770311789 1.03469300991786 0.726885133383238 -0.303440924786016 0.293871467096658 -0.787282803758638 0.888395631757642 -1.14707010696915 -1.06887045816803 -0.809498694424876 -2.94428416199490 1.43838029281510 0.325190539456198 -0.754928319169703 1.37029854009523 -1.71151641885370 -0.102242446085491 -0.241447041607358 0.319206739165502 0.312858596637428 -0.864879917324457 -0.0300512961962686 -0.164879019209038 0.627707287528727 1.09326566903948 1.10927329761440 -0.863652821988714 0.0773590911304249 -1.21411704361541 -1.11350074148676 -0.00684932810334806 1.53263030828475 -0.769665913753682 0.371378812760058 -0.225584402271252 1.11735613881447 -1.08906429505224 0.0325574641649735 0.552527021112224 1.10061021788087 1.54421189550395 0.0859311331754255 -1.49159031063761 -0.742301837259857 -1.06158173331999 2.35045722400204 -0.615601881466894 0.748076783703985 -0.192418510588264 0.888610425420721 -0.764849236567874 -1.40226896933876 -1.42237592509150 0.488193909859941 -0.177375156618825 -0.196053487807333 1.41931015064255 0.291584373984183 0.197811053464361 1.58769908997406 -0.804465956349547 0.696624415849607 0.835088165072682 -0.243715140377952 0.215670086403744 -1.16584393148205 -1.14795277889859 0.104874716016494 0.722254032225002 2.58549125261624 -0.666890670701386 0.187331024578940 -0.0824944253709554 -1.93302291785099 -0.438966153934773 -1.79467884145512 0.840375529753905 -0.888032082329010 0.100092833139322 -0.544528929990548 0.303520794649354 -0.600326562133734 0.489965321173948 0.739363123604474 1.71188778298155 -0.194123535758265 -2.13835526943994 -0.839588747336614 1.35459432800464 -1.07215528838425 0.960953869740567 0.124049800003193 1.43669662271894 -1.96089999936503 -0.197698225974150 -1.20784548525980 2.90800803072936 0.825218894228491 1.37897197791661 -1.05818025798736 -0.468615581100624 -0.272469409250188 1.09842461788862 -0.277871932787639 0.701541458163284 -2.05181629991115 -0.353849997774433 -0.823586525156853 -1.57705702279920 0.507974650905946 0.281984063670556 0.0334798822444514 -1.33367794342811 1.12749227834159 0.350179410603312 -0.299066030332982 0.0228897927516298 -0.261995434966092 -1.75021236844679 -0.285650971595330 -0.831366511567624 -0.979206305167302 -1.15640165566400 -0.533557109315987 -2.00263573588306 0.964229422631628 0.520060101455458 -0.0200278516425381 -0.0347710860284830 -0.798163584564142 1.01868528212858 -0.133217479507735 -0.714530163787158 1.35138576842666 -0.224771056052584 -0.589029030720801 -0.293753597735416 -0.847926243637934 -1.12012830124373 2.52599969211831 1.65549759288735 0.307535159238252 -1.25711835935205 -0.865468030554804 -0.176534114231451 0.791416061628634 -1.33200442131525 -2.32986715580508 -1.44909729283874 0.333510833065806 0.391353604432901 0.451679418928238 -0.130284653145721 0.183689095861942 -0.476153016619074 0.862021611556922 -1.36169447087075 0.455029556444334 -0.848709379933659 -0.334886938964048 0.552783345944550 1.03909065350496 -1.11763868326521 1.26065870912090 0.660143141046978 -0.0678655535426873 -0.195221197898754 -0.217606350143192 -0.303107621351741 0.0230456244251053 0.0512903558487747 0.826062790211596 1.52697668673337 0.466914435684700 -0.209713338388737 0.625190357087626 0.183227263001437 -1.02976754356662 0.949221831131023 0.307061919146703 0.135174942099456 0.515246335524849 0.261406324055383 -0.941485770955434 -0.162337672803828 -0.146054634331526 -0.532011376808821 1.68210359466318 -0.875729346160017 -0.483815050110121 -0.712004549027423 -1.17421233145682 -0.192239517539275 -0.274070229932602 1.53007251442410 -0.249024742513714 -1.06421341288933 1.60345729812004 1.23467914689078 -0.229626450963181 -1.50615970397972 -0.444627816446985 -0.155941035724769 0.276068253931536 -0.261163645776479 0.443421912904091 0.391894209432449'
      mean = 3e-05
      CV = 0.3
    [../]
  [../]
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
  [./strain_zz]
  [../]
[]

[AuxVariables]
  [./d]
  [../]
  [./d_ref]
  [../]
  [./load]
    family = SCALAR
  [../]
[]

[Kernels]
  [./solid_x]
    type = ADStressDivergenceTensors
    variable = disp_x
    component = 0
  [../]
  [./solid_y]
    type = ADStressDivergenceTensors
    variable = disp_y
    component = 1
  [../]
  [./plane_stress]
    type = ADWeakPlaneStress
    variable = strain_zz
  [../]
  [./react_x]
    type = DegradedCoefReaction
    variable = disp_x
    coefficient = 0.1
  [../]
  [./react_y]
    type = DegradedCoefReaction
    variable = disp_y
    coefficient = 0.1
  [../]
[]

[BCs]
  # [./xfix]
  #   type = DirichletBC
  #   variable = disp_x
  #   boundary = 'top bottom left right'
  #   value = 0
  # [../]
  # [./yfix]
  #   type = DirichletBC
  #   variable = disp_y
  #   boundary = 'top bottom left right'
  #   value = 0
  # [../]
  [./Periodic]
    [./x_left_right]
      variable = disp_x
      primary = 'left'
      secondary = 'right'
      translation = '100 0 0'
    [../]
    [./y_left_right]
      variable = disp_y
      primary = 'left'
      secondary = 'right'
      translation = '100 0 0'
    [../]
    [./x_top_bottom]
      variable = disp_x
      primary = 'top'
      secondary = 'bottom'
      translation = '0 -100 0'
    [../]
    [./y_top_bottom]
      variable = disp_y
      primary = 'top'
      secondary = 'bottom'
      translation = '0 -100 0'
    [../]
  [../]
  [./x_pin]
    type = DirichletBC
    variable = disp_x
    value = 0
    boundary = 'center'
  [../]
  [./y_pin]
    type = DirichletBC
    variable = disp_y
    value = 0
    boundary = 'center pin'
  [../]
[]

[Materials]
  [./eigen_strain]
    type = ComputeEigenstrainFromScalarInitialStress
    initial_stress_xx = load
    initial_stress_yy = load
    eigenstrain_name = is
  [../]
  [./elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    poissons_ratio = 0.2
    youngs_modulus = 4
  [../]
  [./strain]
    type = ADComputePlaneSmallStrain
    out_of_plane_strain = strain_zz
    eigenstrain_names = is
  [../]
  [./stress]
    type = SmallStrainDegradedPK2Stress_NoSplit
    history = false
  [../]
  [./fracture_energy_barrier]
    type = StationaryGenericFunctionMaterial
    prop_names = 'b'
    prop_values = 'E_crit'
  [../]
  [./local_dissipation]
    type = LinearLocalDissipation
    d = d
  [../]
  [./fracture_properties]
    type = FractureMaterial
    Gc = 8e-4
    L = 1
    local_dissipation_norm = 8/3
  [../]
  [./degradation]
    type = LorentzDegradation
    d = d
  [../]
[]

[Executioner]
  type = TransientSupNorm
  solve_type = 'NEWTON'
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  dt = 1e-5

  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-06
[]

[Outputs]
  hide = 'load'
  exodus = true
  print_linear_residuals = false
[]
