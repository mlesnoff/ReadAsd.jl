# ReadAsd.jl 

### A Julia package to read ASD binay files of spectra

Read **single** binary files created by the ASD Inc. portable spectrometer instruments, such as the FieldSec 
(for more information, see <http://www.asdi.com/products/fieldspec-spectroradiometers>). The extracted spectral data 
can be returned as reflectance (default), raw (DN), white reference, or radiance. The metadata contained in the ASD 
files are also extracted. 

The core extracting functions of ReadAsd.jl are a port in pure Julia from the **R package `asdreader`** 
(Roudier & Lalibert, 2017), available [here](https://cran.r-project.org/web/packages/asdreader/index.html) and 
[here](https://github.com/pierreroudier/asdreader). Thanks to Pierre Roudier and Etienne Lalibert for their work 
on the R package.

# <span style="color:green"> **Installation** </span> 

To install **ReadAsd** (current version; see the [news](news.md))

```julia
pkg> add https://github.com/mlesnoff/ReadAsd.jl.git
```

### **Author**

Matthieu Lesnoff     
contact: **matthieu.lesnoff@cirad.fr**

- Cirad, [**UMR Selmet**](https://umr-selmet.cirad.fr/en), Montpellier, France

- [**ChemHouse**](https://www.chemproject.org/ChemHouse), Montpellier

### **How to cite**

Lesnoff, M. 2025. ReadAsd: a Julia package to read binary data created by the ASD Inc. portable spectrometer instruments. 
https://github.com/mlesnoff/Jchemo. UMR SELMET, Univ Montpellier, CIRAD, INRA, Institut Agro, Montpellier, France


