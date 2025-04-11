# Read the first three bytes as characters
function get_co(file::String)
    open(file, "r") do f
        seek(f, 0)
        co = read(f, 3)
        return String(co)
    end
end

# Read the comments (157 bytes)
function get_comments(file::String)
    open(file, "r") do f
        seek(f, 3)
        comments = read(f, 157)
        return String(comments)
    end
end

# Read the acquisition date and time
function get_when(file::String)
    open(file, "r") do f
        seek(f, 160)
        # Read 6 integers of 2 bytes each
        # Use read! to read directly into a preallocated array.
        # This allows reading multiple values at once.
        tm = Vector{Int16}(undef, 6)
        read!(f, tm)
        # Convert the values to DateTime
        DateTime(tm[6] + 1900, tm[5] + 1, tm[4], tm[3], tm[2], tm[1])
    end
end

# Read the program version
function get_program_version(file::String)
    open(file, "r") do f
        seek(f, 178)
        res = read(f, UInt8)
        major = res >> 4
        minor = res & 0x0F
        return "$major.$minor"
    end
end

# Read the file version
function get_file_version(file::String)
    open(file, "r") do f
        seek(f, 179)
        res = read(f, UInt8)
        major = res >> 4
        minor = res & 0x0F
        return "$major.$minor"
    end
end

# Read the dark current correction
function get_dc_corr(file::String)
    open(file, "r") do f
        seek(f, 181)
        return Bool(read(f, UInt8))
    end
end

# Read the time of the last dark current correction
function get_dc_time(file::String)
    open(file, "r") do f
        seek(f, 182)
        res = read(f, Int32)
        return DateTime(1970) + Second(res)
    end
end

# Read the data type
function get_data_type(file::String)
    types = ["raw", "reflectance", "radiance", "no_units", "irradiance", "qi", "transmittance", "unknown", "absorbance"]
    open(file, "r") do f
        seek(f, 186)
        res = read(f, UInt8)
        return types[res + 1]
    end
end

# Read the time of the last white reference
function get_ref_time(file::String)
    open(file, "r") do f
        seek(f, 187)
        res = read(f, Int32)
        return DateTime(1970) + Second(res)
    end
end

# Read the starting wavelength in nm
function get_ch1_wavel(file::String)
    open(file, "r") do f
        seek(f, 191)
        return read(f, Float32)
    end
end

# Read the wavelength step in nm
function get_wavel_step(file::String)
    open(file, "r") do f
        seek(f, 195)
        return read(f, Float32)
    end
end

# Read the data format
function get_data_format(file::String)
    formats = ["numeric", "integer", "double", "unknown"]
    open(file, "r") do f
        seek(f, 199)
        res = read(f, UInt8)
        return formats[res]
    end
end

# Read the number of channels in the detector
function get_channels(file::String)
    open(file, "r") do f
        seek(f, 204)
        return read(f, Int16)
    end
end

# Read the integration time in ms
function get_it(file::String)
    open(file, "r") do f
        seek(f, 390)
        return read(f, Int32)
    end
end

# Read the fore optic information
function get_fo(file::String)
    open(file, "r") do f
        seek(f, 394)
        return read(f, Int16)
    end
end

# Read the dark current correction value
function get_dcc(file::String)
    open(file, "r") do f
        seek(f, 396)
        return read(f, Int16)
    end
end

# Read the calibration series
function get_calibration(file::String)
    open(file, "r") do f
        seek(f, 398)
        return read(f, Int16)
    end
end

# Read the instrument number
function get_instrument_num(file::String)
    open(file, "r") do f
        seek(f, 400)
        res = read(f, Int16)
        return string(res)
    end
end

# Read the instrument dynamic range
function get_ip_numbits(file::String)
    open(file, "r") do f
        seek(f, 418)
        return read(f, Int16)
    end
end

# Read the warning flags
function get_flags(file::String)
    open(file, "r") do f
        seek(f, 421)
        return read(f, Int32)
    end
end

# Read the number of dark current corrections
function get_dc_count(file::String)
    open(file, "r") do f
        seek(f, 425)
        return read(f, Int16)
    end
end

# Read the number of white references
function get_ref_count(file::String)
    open(file, "r") do f
        seek(f, 427)
        return read(f, Int16)
    end
end

# Read the number of averaged spectra
function get_sample_count(file::String)
    open(file, "r") do f
        seek(f, 429)
        return read(f, Int16)
    end
end

# Read the instrument type
function get_instrument(file::String)
    instruments = ["unknown", "PSII", "LSVNIR", "FieldSpec VNIR", "FieldSpec FR", "FieldSpec NIR", "CHEM", "FieldSpec FullRange Unattended"]
    open(file, "r") do f
        seek(f, 431)
        res = read(f, UInt8)
        return instruments[res + 1]
    end
end

# Read the bulb ID
function get_bulb(file::String)
    open(file, "r") do f
        seek(f, 432)
        return read(f, Int32)
    end
end

# Read the SWIR1 gain
function get_swir1_gain(file::String)
    open(file, "r") do f
        seek(f, 436)
        return read(f, Int16)
    end
end

# Read the SWIR2 gain
function get_swir2_gain(file::String)
    open(file, "r") do f
        seek(f, 438)
        return read(f, Int16)
    end
end

# Read the SWIR1 offset
function get_swir1_offset(file::String)
    open(file, "r") do f
        seek(f, 440)
        return read(f, Int16)
    end
end

# Read the SWIR2 offset
function get_swir2_offset(file::String)
    open(file, "r") do f
        seek(f, 442)
        return read(f, Int16)
    end
end

# Read the wavelength of the first splice
function get_splice1_wavelength(file::String)
    open(file, "r") do f
        seek(f, 444)
        return read(f, Float32)
    end
end

# Read the wavelength of the second splice
function get_splice2_wavelength(file::String)
    open(file, "r") do f
        seek(f, 448)
        return read(f, Float32)
    end
end

# Read the metadata
function get_metadata(file::String)
    md = Dict()
    md["co"] = get_co(file)
    md["comments"] = get_comments(file)
    md["when"] = get_when(file)
    md["program_version"] = get_program_version(file)
    md["file_version"] = get_file_version(file)
    md["dc_corr"] = get_dc_corr(file)
    md["dc_time"] = get_dc_time(file)
    md["data_type"] = get_data_type(file)
    md["ref_time"] = get_ref_time(file)
    md["ch1_wavel"] = get_ch1_wavel(file)
    md["wavel_step"] = get_wavel_step(file)
    md["data_format"] = get_data_format(file)
    md["channels"] = get_channels(file)
    md["it"] = get_it(file)
    md["fo"] = get_fo(file)
    md["dcc"] = get_dcc(file)
    md["calibration"] = get_calibration(file)
    md["instrument_num"] = get_instrument_num(file)
    md["ip_numbits"] = get_ip_numbits(file)
    md["flags"] = get_flags(file)
    md["dc_count"] = get_dc_count(file)
    md["ref_count"] = get_ref_count(file)
    md["sample_count"] = get_sample_count(file)
    md["instrument"] = get_instrument(file)
    md["bulb"] = get_bulb(file)
    md["swir1_gain"] = get_swir1_gain(file)
    md["swir2_gain"] = get_swir2_gain(file)
    md["swir1_offset"] = get_swir1_offset(file)
    md["swir2_offset"] = get_swir2_offset(file)
    md["splice1_wavelength"] = get_splice1_wavelength(file)
    md["splice2_wavelength"] = get_splice2_wavelength(file)
    md
end

# Build a vector of wavelengths from metadata
function get_wavelengths(md::Dict)
    start = md["ch1_wavel"]
    step = md["wavel_step"]
    n = md["channels"]
    end_wl = start + (n - 1) * step
    collect(start:step:end_wl)
end
