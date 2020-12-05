# ssoem.jl
Super Simple Open EtherCAT Master

## About
ssoem.jl is a basic EtherCAT master library for julia, based on SOEM (Simple Open EtherCAT Master).
It's goal is to get an EtherCAT bus up and running, and to read and write variables on this bus with just a few lines of code.
The goal is not to be a high-performance / real-time library; for that use SOEM, beckhoff, XPc, or any other EtherCAT master designed for that usecase.

## Example
```julia
include("ssoem.jl")
ec = Ssoem("en4") # create an ethercat bus on ethernet interface "en4"
write(ssoem.slaves[6], 1, UInt16(2000))
ans = read(ssoem.slaves[3], 3, UInt16)
```

## Installation
TODO

## Usage
TODO

## Technical info
This library is a wrapper around a C library (ssoem.c) which uses SOEM to start and maintain a running EtherCAT bus.
It does this by spawning 2 threads; one to continuously update the bus data, and the other to periodically check and maintain the bus in the operational state.

The raw byte-array data (IOmap) from the SOEM library can be read from and written to by the julia wrapper.

## To-do
- auto-detect PDO objects
- SDO read/write
- Improved documentation
- Build scripts for Linux, Windows, MacOS
- ...