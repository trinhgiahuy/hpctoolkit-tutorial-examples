This directory contains support for performance experiments with a collection of 
GPU-accelerated programs and benchmarks. For convenience of tutorial scale,
our experiments with these codes using only a single GPU.


1. laghos - (LAGrangian High-Order Solver) is a miniapp that solves the
            time-dependent Euler equations of compressible gas dynamics in a 
            moving Lagrangian frame.

2. lammps - a classical molecular dynamics code that uses the Kokkos 
            template-based programming model to offload computation to GPUs  
            Note: lammps is a big code. It takes about 8 minutes to build.

3. lulesh - a shock hydrodynamics mini-app from LLNL. Multiple versions of lulesh
            were written to evaluate various programming models and abstractions.
            Here we use HPCToolkit to measure the performance of two 
            of GPU-accelerated versions of lulesh. 

   - lulesh-acc - the OpenACC version

   - lulesh-omp  - the OpenMP version

4. miniqmc - a miniapp for QMCPACK, a simplified real space ab initio Quantum 
             Monte Carlo code for computing the electronic structure of atoms, 
             molecules, and solids with portable GPU support using OpenMP

5. pelec -  a turbulent combustion code built using the ECP AMReX (AMR for Exascale) 
            adaptive mesh refinement framework  

6. quicksilver - a LLNL proxy application for dynamic Monte Carlo particle transport

Our experiments with these GPU-accelerated codes collect two kinds of measurement 
data:

1. Profiles and traces of CPU and GPU activity. Profiles and traces of CPU activity 
   are collected using asynchronous sampling. GPU activity is profiled and traced
   at the level of individual GPU operations, e.g. kernel executions, memory copies,
   etc.

2. Fine-grain detail inside GPU kernels with PC sampling. NVIDIA's PC samples 
   come with stall information. Stalls are a sign of inefficiency. NVIDIA GPUs
   report about a dozen kinds of stall reasons, including latency for global memory
   accesses, instruction fetch latency, instruction dependences, memory throttling,
   etc.

   In addition to fine-grain dynamic measurements at the instruction level , on 
   NVIDIA GPUs HPCToolkit also reports static kernel characteristics, e.g. register 
   consumption, shared memory consumption, as well as dynamic measurements such as
   average number of blocks in launches of a kernel in a context, utilization, etc.       
