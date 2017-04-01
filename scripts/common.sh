
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
  ssh -A -o "ConnectTimeout 1" -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" "$@"
}

scpx() {
  scp    -o "ConnectTimeout 1" -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" "$@"
}

sshix() {
  ssh -A -o "ConnectTimeout 1" -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" -o "LogLevel=quiet" "$@"
}

scpix() {
  scp    -o "ConnectTimeout 1" -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" -o "LogLevel=quiet" "$@"
}

announce() {
  echo 1>&2
  echo 1>&2
  echo 1>&2
  echo "======================================================================================" 1>&2
  echo "$@" 1>&2
  echo "======================================================================================" 1>&2
  echo 1>&2
  echo 1>&2
  echo 1>&2
}

reboot() {
  echo "Rebooting after $1" 1>&2
  sudo shutdown -r now
  sleep 2
  exit 253
}

check_reboot() {

  # Reboot?
  if [[ -f /var/run/reboot-required ]]; then
    reboot "$@"
  fi
}

wait_for_start() {
  echo "wait for start |${1}| whoami" 1>&2
  while ! sshx -o ConnectTimeout=5 ${1} whoami; do
    sleep 3
    echo "wait for start |${1}| whoami" 1>&2
  done
  sleep 3
}

