# vle-thermo

MATLAB code for vapour-liquid equilibrium (VLE) calculations of binary fuel–nitrogen mixtures at high pressure, using the Peng-Robinson equation of state. Originally developed at Chalmers to support spray-evaporation modelling in diesel-engine combustion vessels.

A companion LaTeX writeup of the formulation is included under [docs/](docs/).

## Files

| File | Purpose |
|---|---|
| `VLE.m` | Top-level: computes the saturation curve for a fuel/N₂ binary at 3, 4.5, and 6 MPa |
| `PREOS.m` | Symbolic Peng-Robinson EOS — returns expressions for fugacity, molar volume, and the VLE objective function |
| `propData.m` | Critical properties (`Tc`, `pc`, `ω`) lookup for supported substances |
| `phaseDiagram.m` | Plots the resulting *T*–*x*–*y* phase diagram |
| `plotVLE.m` | Generic VLE result plotting |
| `v.m` | Molar volume helper |
| `Unused/` | Older / experimental scripts (density mapping, influence parameter, binary interaction parameter) |
| `docs/` | LaTeX + PDF derivation: *VLE as a function of primary variables* |

## Supported fuels

`'butanol'`, `'dodecane'`, `'hexadecane'`, `'nitrogen'`. Binary-interaction parameters for dodecane (k = 0.2082) and hexadecane (k = 0.1816) are taken from Liu & Reitz, *IJMF* 2014.

## Usage

```matlab
[yeq, x, Teq] = VLE('dodecane');
```

On first call, `PREOS` writes out auto-generated MATLAB functions for the molar volume and the VLE objective; subsequent calls reuse them.

## Requirements

MATLAB with the Symbolic Math Toolbox.
