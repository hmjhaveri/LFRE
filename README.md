# LFRE
Authors: Harsh Jhaveri (hjhaveri at umich dot edu), Rahul Srinivasan

MATLAB Implementation of the Local-Filtering based Resilient Estimation (LFRE) Algorithm published by Mitra et. al. (2019), "Byzantine-resilient distributed observers for LTI systems."

## Replication of Published Simulation Results
The published results are implemented and replicated in `LFRE_driver.m`. This file also contains the main documentation for the data structures uses to define the graph topology. This structure is used in all examples, but only defined in detail in this file. Example files are documented in the following sections. For utility functions, see the specific `.m` files for detailed documentation and comments.

### One Dimensional Examples
A variety of one dimensional examples extending the published example are implemented in `LFRE_Driver_1d.m`

### Two Dimensional Examples
An extension of the published work in one dimension to two dimensional state vectors is implemented in `LFRE_Driver_2d.m`

## LFRE Algorithm Implementation
The LFRE algorithm is implemented in `LFRE.m` for a one-dimensional state and `LFRE_2d.m` for a two-dimensional state. While LFRE has not been implemented for higher dimensions, we suspect that `LFRE_2d.m` can be modified very easily to work in N dimensions.


