# convert_and_import

This workflow will convert all files in `images` directory, convert them to 'ome.tiff' (then available in `converted` directory)
and upload them to the demo server (put your credentials and a target Dataset in `login.yml`).

You also have to adjust the full path to the conda env yaml `omero-env.yml` in `omero.nf`!

Then run it with 
```
nextflow run -with-conda --imgdir images --outdir converted -params-file login.yml omero.nf
```

