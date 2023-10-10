# [Posten signering](https://signering.posten.no) documentation site

Sources for building the documentation site at [signering-docs.readthedocs.io](https://signering-docs.readthedocs.io)

[![Documentation Status](https://readthedocs.org/projects/signering-docs/badge/?version=latest)](https://signering-docs.readthedocs.io/en/latest/?badge=latest)

## ✅ Prerequisites

1. **Install Python 3**

   Building the documentation site with [Sphinx](http://www.sphinx-doc.org) requires Python v3:

   ```shell
   brew install python
   ```

2. **Link Python 3**

   Link ``python3`` as described in [Stackoverflow](https://stackoverflow.com/a/49711594/1765749). By adding it first in `PATH` environment variable, it will be chosen before the really old one installed by default on macOS.

3. **Install dependencies for building the documentation**

   ```shell
   pip install -r requirements.txt
   pip install sphinx-autobuild
   ```

4. **Do a build to verify everything works**
   ```shell
   make clean html
   ```


## 🏗 Building

### Local development

To run a self-updating webserver using `sphinx-autobuild`:
```shell
make autobuild
```

The site is continuously and incrementally built when changes are made to the sources.

For editing the documentation content (*.rst files), the default behavior of `autobuild` should be sufficient. However, sometimes the incremental build fails to include some updates. This is the case e.g. when editing static assets as custom CSS. To activate _full_ automatic build with `autobuild`, you can supply command options for [sphinx-autobuild](https://github.com/executablebooks/sphinx-autobuild) by setting `SPHINXOPTS="-a"` in order to [disable the incremental build feature](https://github.com/executablebooks/sphinx-autobuild#working-on-a-sphinx-html-theme)
```shell
make autobuild SPHINXOPTS="-a"
```





### Building the site

To build the site, run:

```shell
make clean html
```



## 🛠 Tools

### Convert markdown to reStructuredText

If not already installed, install [pandoc](https://pandoc.org/) with e.g. `brew install pandoc`.

```shell
pandoc markdown-file.md --from gfm --to rst -s -o output-file.rst --wrap=preserve
```

The example converts [GitHub Flavored Markdown](https://github.github.com/gfm/) using `--from gfm`. Substitute the source format with [something else](https://pandoc.org/MANUAL.html#option--from) if you need to. It is important to use `wrap=preserve` to avoid splitting one-liners into multiple lines.
