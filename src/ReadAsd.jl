module ReadAsd  # Start-Module

using DataFrames
using Dates

include("get_metadata.jl")
include("get_spectrum.jl")
include("readsp.jl")

export 
    get_metadata,
    get_wavelengths,
    get_spec,
    process_spectrum!,
    readsp
end # End-Module


