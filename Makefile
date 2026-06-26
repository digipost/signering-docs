# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SOURCEDIR     = source
BUILDDIR      = build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Sphinx autobuild
autobuild:
	@sphinx-autobuild "$(SOURCEDIR)" "$(BUILDDIR)/html" -t authoring $(SPHINXOPTS) $(O)

#Copy the .rst files into the build folder to serve them for LLMs
rst_copy:
	@rsync -a --include='*/' --include='*.rst' --exclude='*' "$(SOURCEDIR)/" "$(BUILDDIR)/html/"

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@$(MAKE) rst_copy