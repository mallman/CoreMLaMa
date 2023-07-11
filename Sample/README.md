## CoreMLaMa Sample App

This is a sample Mac console app demonstrating how to use LaMa.mlpackage to perform inpainting in Swift.

You need macOS 12 or later and Xcode to build and run this app.

1. Create LaMa.mlpackage in the parent directory with the convert_lama.py conversion script.
2. Run compile_model.sh to compile the model and generate the Swift class.
3. Load Package.swift in Xcode. Xcode should automatically generate an executable scheme.
4. Run it.
