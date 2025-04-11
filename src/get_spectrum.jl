struct Spec
    spectrum::Vector{Float64}
    wr::Vector{Float64}    
end 

# Read a spectrum file
function get_spec(file::String, md::Dict)
    open(file, "r") do f
        # Move to the correct position in the file
        seek(f, 484)

        # Read the raw spectrum
        #spec = Vector{Float32}(undef, md["channels"])
        spec = Vector{Float64}(undef, md["channels"])
        read!(f, spec)
        #println(spec)

        # Read the white reference flag
        seek(f, 484 + 8 * md["channels"])
        wr_flag = read(f, Bool)

        # Read the white reference time
        seek(f, 484 + 8 * md["channels"] + 2)
        wr_time = read(f, Int32)

        # Read the spectrum time
        seek(f, 484 + 8 * md["channels"] + 10)
        spec_time = read(f, Int32)

        # Read the length of the spectrum description
        seek(f, 484 + 8 * md["channels"] + 18)
        spec_description_length = read(f, UInt16)  # Use UInt16 to avoid negative values

        # Read the spectrum description
        seek(f, 484 + 8 * md["channels"] + 20)
        spec_description = String(read(f, spec_description_length))

        # Read the white reference
        seek(f, 484 + 8 * md["channels"] + 20 + spec_description_length)
        wr = Vector{Float64}(undef, md["channels"])
        read!(f, wr)

        Spec(spec, wr)
    end
end

# Normalize a signal
function normalize!(x::Vector{Float64}, md::Dict)
    wl = get_wavelengths(md)
    idx1 = findall(wl .<= md["splice1_wavelength"])
    idx2 = findall((wl .> md["splice1_wavelength"]) .& (wl .<= md["splice2_wavelength"]))
    idx3 = findall(wl .> md["splice2_wavelength"])
    x[idx1] ./= md["it"]
    x[idx2] .*= md["swir1_gain"] / 2048
    x[idx3] .*= md["swir2_gain"] / 2048
    x
end

# Process an return a spectrum
function process_spectrum!(spec::Spec, md::Dict, type::String)

    if type == "reflectance"

        if md["data_type"] in ["radiance", "reflectance"]
            spec.spectrum ./= spec.wr
        elseif md["data_type"] == "raw"
            normalize!(spec.spectrum, md)
            normalize!(spec.wr, md)
            spec.spectrum ./= spec.wr
        else
            error("The file only contains data of type $(md["data_type"]).")
        end

    elseif type == "radiance"

        if md["data_type"] in ["radiance", "reflectance"]
        elseif md["data_type"] == "raw"
            normalize!(spec.spectrum, md)
        else
            error("The file only contains data of type $(md["data_type"]).")
        end
    
    elseif type == "raw"

        if md["data_type"] != "raw"
            error("The file only contains data of type $(md["data_type"]).")
        end
    
    elseif type == "white_reference"

        if md["data_type"] in ["radiance", "reflectance"]
            spec.spectrum .= spec.wr
        elseif md["data_type"] == "raw"
            normalize!(spec.wr, md)
            spec.spectrum .= spec.wr
        else
            error("Invalid data type requested.")
        end

    else
        error("Invalid data type requested.")
    end

    spec.spectrum

end




