
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

# Adding file support adds TMP_DIR, rm it
cli_shezargs_cleanup() {
  if [[ -n $CLI_SHEZARGS_TMP_DIR ]]; then
    if [[ -d $CLI_SHEZARGS_TMP_DIR ]]; then
      rm -rf $CLI_SHEZARGS_TMP_DIR
    fi
  fi
}

RESET="\033[0m"
RED="\033[31m"
YELLOW="\033[33m"
REDBG="\033[41m"

echoerr() { echo "$@" 1>&2; }
echoerr_red() { echo -e "${RED}${@}${RESET}" 1>&2; }
echoerr_redbg() { echo -e "${REDBG}${@}${RESET}" 1>&2; }
echoerr_yellow() { echo -e "${YELLOW}${@}${RESET}" 1>&2; }

start_dir="$(pwd)"
script_dir="$(dirname $0)"

scripts_dir="$script_dir"
if [[ ${scripts_dir:0:1} != / ]]; then
  scripts_dir="$(realpath $scripts_dir)"
fi

