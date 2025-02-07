# [Posten signering](https://signering.posten.no) documentation site

Sources for building the documentation site at [signering-docs.readthedocs.io](https://signering-docs.readthedocs.io)

[![Documentation Status](https://readthedocs.org/projects/signering-docs/badge/?version=latest)](https://signering-docs.readthedocs.io/en/latest/?badge=latest)

## ✅ Prerequisites

1. **Install pyenv for managing Python versions**

   ```shell
   brew install pyenv pyenv-virtualenv
   ```

   And add the following snippet to your `.zshrc` or any other startup script for your shell:

   ```shell
   eval "$(pyenv init -)"
   if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
   ```

   Open a new shell (terminal window) to ensure pyenv is initialized. Check available versions of Python with this command: (long list)

   ```shell
   pyenv install -l
   ```


2. **Install Python 3.13**

   Building the documentation site with [Sphinx](http://www.sphinx-doc.org) requires Python v3:

   ```shell
   pyenv install 3.13.2
   ```
   Feel free to substitute the version with any later available 3.13.x version.



3. **Set up a new virtualenv and dependencies**

   Change to folder of your cloned working copy of this repository.

   If you already have set up a virtualenv (your prompt includes "(signering-docs)"), and you want to upgrade its version of Python (`python --version` print a version earlier than 3.13.2), first delete the existing virtualenv:

   ```shell
   pyenv virtualenv-delete signering-docs
   ```

   ```shell
   pyenv virtualenv 3.13.2 signering-docs  #create a new virtualenv 'signering-docs'
   pyenv local signering-docs  #this sets up 'signering-docs' as the virtualenv to use here
   pip install -r requirements.txt
   ```
   Your prompt should now include `(signering-docs)`, which signifies an "active" virtualenv being used. It disappears when exiting the directory. Feel free to use another name than signering-docs should you wish, but it is considered good practice to generally not reuse virtualenvs cross projects.



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
