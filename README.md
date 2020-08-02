# Saner Dependency Management in Python

This is the companion repo to my [YouTube video](https://youtu.be/aWVzR296XcU) talking
about a better way to manage dependencies in Python.


## Prepare Your Python Environment

```
python3 -m venv ./venv
source ./venv/bin/activate
```

Your newly created virtualenv should now be activated if your prompt changed
to the following:

```
(venv) ubuntu@dev...
```

or, should you happen to be using [dotfiles.relaxdiego.com](https://dotfiles.relaxdiego.com),
it should have changed to something similar to the following

```
... via 🐍 v3.7.7 (venv)
```

## Install The Dependencies

Install all development and runtime dependencies.

WARNING: Make sure you are using a virtualenv before running this command. Since it
         uses pip-sync to install dependencies, it will remove any package that is not
         listed in either `dev-requirements.in` or `setup.py`. If you followed the steps
         in Prepare Your Development Environment above, then you're good.

```
make dev-install
```


## Adding A Development Dependency

1. Add it to `dev-requirements.in` and then run make dev-install:

```
echo "foo" >> dev-requirements.in
make dev-install
```

This will create `dev-requirements.txt` and then install all dev-dependencies


2. Commit `dev-requirements.in` and `dev-requirements.txt`. Both
   files should now be updated and the `foo` package installed in your
   local machine. Make sure to commit both files to the repo to let your
   teammates know of the new dependency.

```
git add dev-requirements.*
git commit -m "Add foo to dev-requirements.txt"
git push origin
```


## Adding A Runtime Dependency

1. Add it to `runtime_requirements` list in setup.py and then run:

```
make requirements.txt
```

This will create `requirements.txt` and then install all dependencies


2. Commit `setup.py` and `requirements.txt`. Both
   files should now be updated and the `foo` package installed in your
   local machine. Make sure to commit both files to the repo to let your
   teammates know of the new dependency.

```
git add requirements.txt
git add setup.py
git commit -m "Add bar to runtime requirements"
git push origin
```


## Need A Fresh Start?

Sigh, what I'd give to get a fresh start in life too. Huh? Oh you mean a fresh start
in the project? Well we got you covered there too! Just run:

```
make clean
```

Or if you really want to clean all the stuff

```
make clean all=t
```


## Had Enough?

Make sure to deactivate the virtual environment and remove it if you want

```
deactivate
rm -rf venv
```
