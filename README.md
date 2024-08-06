# psi4-isambard

A conda recipe for building [Psi4](https://psicode.org) on [Isambard AI](https://isambard.ac.uk) (NVIDIA Grace Hopper, Linux aarch64).
Adapted from the Psi4 conda-forge [feedstock](https://github.com/conda-forge/psi4-feedstock).

## Building

To build the package locally:

```
git clone https://github.com/OpenBioSim/psi4-isambard.git
cd psi4-isambard
conda build -c conda-forge .
```

## Installation

Install via conda using:

```
conda install -c conda-forge -c openbiosim/label/isambard psi4 libopenblas=*=*openmp*
```

Or create an isolated environment with:

```
conda create -n psi4 -c conda-forge -c openbiosim/label/isambard psi4 libopenblas=*=*openmp*
```
