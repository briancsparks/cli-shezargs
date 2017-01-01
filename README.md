# cli-shezargs #

A utility to make command-line shell args easy to use. (I should have called it "cli-sh-ez-args", but that seemed
cumbersome.)

### Overview ###

I always hated the boiler plate at the top of all of my shell scripts:

```sh
#!/bin/bash -e

# Helper functions
die() {
  echo "$@"
  exit 1
}

# ...

# parse args
for param in "$@"; do
  case $param in

    --service=*)
      service="${param#*=}"
      ;;

    # ...

  esac
done

# ...

```

Now, I can just:

```sh
#!/bin/bash -e

# parse args and setup common functions
eval "$(cli-shezargs $@)"

# ...

```

### What You Get ###

The main benefit is that you will have variables set for each command-line
argument. But you also get ```die()``` and some other functions.

```sh

# "--foo=quxx" becomes

export foo="quxx"

# and "beanie --foo-be=bar baby --foo-it --baz- --foo=quxx -- --not-an-arg" becomes

export foo_be="bar"
export foo_it="1"
unset baz
export foo="quxx"
set -- "beanie" "baby" "--not-an-arg"

```

That last line has the effect of setting $1 to "beanie", $2 to "baby", $3 to "--not-an-arg", and $# to 3.

Look at ```scripts/common.sh``` for the functions that you will have. Modify and submit a PR to add your favorites. :)

# How To #

You must have Node.js, and then:

Install:

```sh
npm install -g cli-shezargs
```

Put this snippet at the top of your scripts:

```sh
eval "$(cli-shezargs $@)"
```

And then use ```--this-style-of=command --line- --args```

