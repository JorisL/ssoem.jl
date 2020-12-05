# ssoem.jl
Super Simple Open EtherCAT Master

## About
ssoem.jl is a basic EtherCAT master library for julia, based on SOEM (Simple Open EtherCAT Master).
It's goal is to get an EtherCAT bus up and running, and to read and write variables on this bus with just a few lines of code.
The goal is not to be a high-performance / real-time library; for that use SOEM, beckhoff, XPc, or any other EtherCAT master designed for that usecase.

## Example
```julia
julia> include("ssoem.jl")

julia> ec = Ssoem("en4") # create an ethercat bus on ethernet interface "en4"

julia> ec.slaves
6-element Array{Slave,1}:
 Slave("EK1100", 0x0000, 0x00000000, Ptr{UInt8} @0x00007f8b398beb50, UInt8[], 0x00, 0x0000, 0x00000000, Ptr{UInt8} @0x0000000000000000, UInt8[], 0x00)
 Slave("EL1018", 0x0000, 0x00000000, Ptr{UInt8} @0x00007f8b398beb50, UInt8[], 0x00, 0x0008, 0x00000001, Ptr{UInt8} @0x000000012067a1ba, UInt8[0x00], 0x00)
 Slave("EL3024", 0x0000, 0x00000000, Ptr{UInt8} @0x00007f8b398beb50, UInt8[], 0x00, 0x0080, 0x00000010, Ptr{UInt8} @0x000000012067a1bb, UInt8[0x00, 0x00, 0x28, 0x00, 0x41, 0x00, 0x00, 0x00, 0x41, 0x00, 0x00, 0x00, 0x41, 0x00, 0x00, 0x00], 0x00)
 Slave("EL2828", 0x0008, 0x00000001, Ptr{UInt8} @0x00007f8c59f38d00, UInt8[0x00], 0x00, 0x0000, 0x00000000, Ptr{UInt8} @0x0000000000000000, UInt8[], 0x00)
 Slave("EL2624", 0x0004, 0x00000000, Ptr{UInt8} @0x00007f8c59f38d01, UInt8[0x00], 0x00, 0x0000, 0x00000000, Ptr{UInt8} @0x0000000000000000, UInt8[], 0x00)
 Slave("EL4024", 0x0040, 0x00000008, Ptr{UInt8} @0x00007f8c59f38d02, UInt8[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00], 0x00, 0x0000, 0x00000000, Ptr{UInt8} @0x0000000000000000, UInt8[], 0x00)

julia> write(ec.slaves[6], 3, UInt16(0x3333))

julia> read(ec.slaves[3], 3, UInt16)
0x3363
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
