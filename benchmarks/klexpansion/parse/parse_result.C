//* This file is part of the RACCOON application
//* being developed at Dolbow lab at Duke University
//* http://dolbow.pratt.duke.edu

// libMesh include files.
#include "libmesh/libmesh.h"
#include "libmesh/mesh.h"
#include "libmesh/mesh_generation.h"
#include "libmesh/exodusII_io.h"
#include "libmesh/eigen_system.h"
#include "libmesh/equation_systems.h"
#include "libmesh/slepc_eigen_solver.h"
#include "libmesh/fe.h"
#include "libmesh/quadrature_gauss.h"
#include "libmesh/dense_matrix.h"
#include "libmesh/sparse_matrix.h"
#include "libmesh/numeric_vector.h"
#include "libmesh/dof_map.h"
#include "libmesh/enum_eigen_solver_type.h"
#include "libmesh/petsc_matrix.h"
#include "slepcsys.h"

#include <vector>
#include <iostream>
#include <algorithm>

#include "libmesh/equation_systems.h"
#include "libmesh/exodusII.h"
#include "Node.h"
#include <fstream>


// Bring in everything from the libMesh namespace
using namespace libMesh;


int
main(int argc, char ** argv)
{
  // Check for proper usage.
  if (argc != 2)
    libmesh_error_msg("\nUsage: " << argv[0]);

  // // Initialize libMesh and the dependent libraries.
  // LibMeshInit init(argc, argv);
  //
  // Mesh mesh(init.comm());
  // // Initialize the data structures for the equation system.
  // libMesh::out << "Initializing equation system...";
  // libMesh::out << "complete" << std::endl;


  // ExodusII_IO exo(mesh);
  // exo.read(argv[1]);
  // std::vector<Real> _time_step;
  // // const std::vector<Real> & _time_step;
  // _time_step = exo.get_time_steps();
  // libMesh::out << _time_step.size() << std::endl;
  // libMesh::out << _time_step.back() << std::endl;
  // libMesh::out << exo.get_num_time_steps() << std::endl;
  //
  // std::vector <std::string> _nodal_variables;
  // _nodal_variables = exo.get_nodal_var_names();
  // libMesh::out << _nodal_variables[0] <<' '<<_nodal_variables[1]<<' '<<_nodal_variables[2]<<std::endl;
  std::cout<<"--------------------------------------"<<std::endl;
  // ExodusII exoo;
  int CPU_word_size,IO_word_size, exoid;
  float version;
  CPU_word_size = sizeof(double);
  IO_word_size = 0;
  exoid = ex_open(argv[1],EX_READ,&CPU_word_size, &IO_word_size, &version);
  if(exoid<0)
  {
    std::cout<<"cannot open"<<std::endl;
    exit(exoid);
  }

  libMesh::out << "start reading" << std::endl;
  int num_dim, num_nodes, num_elem, num_elem_blk, num_node_sets, num_side_sets, error;
  char title[MAX_LINE_LENGTH+1];
  error = ex_get_init(exoid,title,&num_dim, &num_nodes, &num_elem, &num_elem_blk, &num_node_sets, &num_side_sets);
  if(error)
  {
    std::cout<<"error init"<<std::endl;
    ex_close(exoid);
    exit(error);
  }
  //std::cout<<"num_dim"<<num_dim<<std::endl;
  //std::cout<<"num_nodes"<<num_nodes<<std::endl;
  //std::cout<<"num_elem"<<num_elem<<std::endl;


  int num_time_steps;
  //float * time_values;
  num_time_steps = ex_inquire_int(exoid, EX_INQ_TIME);
  //time_values = (float *)calloc(num_time_steps, sizeof(float));
  //error = ex_get_all_times(exoid, time_values);
  //if(error)
  //{
  //  std::cout<<"error get_all_times"<<std::endl;
  //  ex_close(exoid);
  //  exit(error);
  //}
  //free(time_values);
  //std::cout<<"num_time_steps "<<num_time_steps<<std::endl;

  //double *x, *y, *z;
  //libMesh::out << "-" << std::endl;
  double * x = (double *)calloc(num_nodes,sizeof(double));
  //libMesh::out << "-" << std::endl;
  double * y = (double *)calloc(num_nodes,sizeof(double));
  double * z = (double *)calloc(num_nodes,sizeof(double));
  //libMesh::out << "-" << std::endl;
  error = ex_get_coord(exoid, x, y, z);
  if(error)
  {
    std::cout<<"error coord"<<std::endl;
    ex_close(exoid);
    exit(error);
  }
  std::vector<_Node*> _nodes;
  for (int i= 0; i < num_nodes; i++)
  {
    // std::cout<<x[i]<<std::endl;
    _Node * tmp = new _Node(i,x[i],0);
    _nodes.push_back(tmp);
  }
  free(x);
  free(y);
  free(z);
  //libMesh::out << "finish reading nodes" << std::endl;


  int num_nodal_vars;
  error = ex_get_variable_param(exoid, EX_NODAL, &num_nodal_vars);
  //libMesh::out << "finish reading num_nodal_var" << std::endl;


  char * var_name = (char *)calloc((MAX_STR_LENGTH+1), sizeof(char));
  double * d = (double *)calloc(num_nodes,sizeof(double));
  double * Gc = (double *)calloc(num_nodes,sizeof(double));
  double * E = (double *)calloc(num_nodes,sizeof(double));
  for (int i = 0; i < num_nodal_vars;i++)
  {
    error = ex_get_variable_name(exoid, EX_NODAL, i+1, var_name);
    if (var_name[0] == 'd')
    error = ex_get_nodal_var(exoid, num_time_steps, i+1, num_nodes, d);
    else if (var_name[0] == 'G')
    error = ex_get_nodal_var(exoid, num_time_steps, i+1, num_nodes, Gc);
    else if (var_name[0] == 'E')
    error = ex_get_nodal_var(exoid, num_time_steps, i+1, num_nodes, E);
  }
  //libMesh::out << "finish reading" << std::endl;
  for (size_t i = 0; i <num_nodes; i++)
  {
    _nodes[i]->d() = d[i];
    _nodes[i]->Gc() = Gc[i];
    _nodes[i]->E() = E[i];
  }


  std::ofstream _nodal_out;
  std::string _out_file = argv[1];
  _out_file = _out_file.substr(0,_out_file.size()-2);
  _out_file =_out_file +"_timestep"+std::to_string(num_time_steps)+".dat";
  libMesh::out <<"start writing "<< _out_file<< std::endl;
  _nodal_out.open(_out_file);
  // libMesh::out << "-" << std::endl;
  _nodal_out << "node" << " damage" << " Gc" << " E" << " x" << std::endl;
  for (size_t i = 0; i < _nodes.size();i++)
  {
    // libMesh::out << "-" << std::endl;
    _nodal_out<<_nodes[i]->id()<<" "<<_nodes[i]->d()<<" "<<
    _nodes[i]->Gc()<<" "<<_nodes[i]->E()<<" "<<_nodes[i]->x()<<"\n";
  }
  _nodal_out.close();
  free(d);
  free(Gc);
  free(E);
  free(var_name);
  
  for (int i = 0; i <num_nodes;i++)
  {
    delete[] _nodes[i];
  }

  error = ex_close(exoid);


  return EXIT_SUCCESS;
}
