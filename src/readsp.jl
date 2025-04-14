"""
    readsp(path::String; type::String = "reflectance")
    Read ASD files stored in a directory.
* `path` : Path to the files.
* `type` : Type of the spectra returned by the function. Possible values are : "reflectance" (default), 
       "radiance", "raw" and "white_reference".

The function reads all the files '.asd' available in the directory `path` and returns a tuple containing:
* `X` : A DataFrame containing the spectra.
* `wl` : The wavelengths of the spectra.
* `f` : The names of the files.
* `md` : A vector of dictionaries containing the metadata of each file.

The function uses the `get_metadata`, `get_spec`, and `process_spectrum!` functions to read and process
the spectra. These functions are a port in pure Julia of the core functions of the R package
`asdreader` (Roudier & Lalibert, 2017).

## References
Roudier P., Lalibert E., 2017. asdreader: Read ASD files in R. R package version 0.1-3. 
DOI:	10.32614/CRAN.package.asdreader
https://cran.r-project.org/web/packages/asdreader/index.html
https://github.com/pierreroudier/asdreader


## Examples
```julia
using ReadAsd

path_f = "path/to/your/files"  # path of the directory containing the single files '.asd'

res = readsp(path_f) 
res.X     # dataFrame with the spectral data 
res.wl    # wavelengths (nm)
res.f     # file names of the spectra

i = 1     # index of the file
md = res.md[i]
md["program_version"]
md["file_version"]
md["data_type"]
```
""" 
function readsp(path::String; type::String = "reflectance")
    f = filter(endswith("asd"), readdir(path))
    n = length(f)
    sp = Vector{Vector{Float64}}(undef, n)
    md = Vector{Dict}(undef, n)
    for i in eachindex(f)
        db = joinpath(path, f[i])
        md[i] = get_metadata(db)
        spec = get_spec(db, md[i]) 
        sp[i] = process_spectrum!(spec, md[i], type)
    end
    wl = get_wavelengths(md[1])
    p = length(sp[1]) 
    X = permutedims(reshape(reduce(vcat, sp), p, n))
    X = DataFrame(X, string.(wl))
    (X = X, wl, f, md)
end


