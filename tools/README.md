<img src="../img/logo_amds.png" alt="Logo" height="128px"/>

# AmsterdamUMCdb - Freely Accessible ICU Database
version 1.0.2 March 2020  
Copyright &copy; 2003-2020 Amsterdam UMC - Amsterdam Medical Data Science

# Tools folder
This folder contains some sampe code for manipulating files.

## zip.ipynb
Creates a zip file with files from a specific path. Uses a wrapper function to get
progress status from the write function that (indirectly) is called by ZipFile. Displays progress
using two tqdm progress bars.

## unzip.ipynb
Uses a simple class as a file-like object wrapper that can be used to extract a ZipFile while at the same time updating a progress bar.