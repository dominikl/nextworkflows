process bf2raw {
  conda '/home/dom/omero-env.yml'

  input:
  path imgfile
  output:
  path "${imgfile.baseName}.zarr"

  script:
  def outfile = "${imgfile.baseName}.zarr"
  """
  bioformats2raw ${imgfile}  ${outfile}
  """
}

process r2t {
  conda '/home/dom/omero-env.yml'
  publishDir params.outdir, overwrite: true

  input:
  path zarr
  output:
  path "${zarr.baseName}.tiff"

  script:
  def outfile = "${zarr.baseName}.tiff"
  """
  raw2ometiff ${zarr} ${outfile}
  """
}

process omero {
  conda '/home/dom/omero-env.yml'

  debug true

  input:
  path img

  script:
  """
  omero -s ${params.omero_server} -u ${params.omero_user} -w ${params.omero_pass} import -T ${params.omero_dataset} ${img}
  """
}

workflow {
    bf2raw(Channel.fromPath("${params.imgdir}/*"))
    r2t(bf2raw.out)
    omero(r2t.out)
}

