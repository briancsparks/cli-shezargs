
die() {
  echo "$@" 1>&2
  exit 1
}

fn() {
  DIR="./"
  if [[ "$#" > 1 ]]; then
    DIR="$1"
    shift
  fi

  find $DIR -type f | egrep -v node_modules | egrep -i "$@"
}

fd() {
  DIR="./"
  if [[ "$#" > 1 ]]; then
    DIR="$1"
    shift
  fi

  find $DIR -type d | egrep -v node_modules | egrep -i "$@"
}

sshx() {
  ssh -A -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" "$@"
}

scpx() {
  scp -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" "$@"
}

