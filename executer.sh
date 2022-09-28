#!/usr/bin/env bash

script_dir=$(dirname $(realpath "$0"))
base=$(basename "$0")

source "$script_dir/common.sh"
source "$script_dir/base.sh"
source "$script_dir/bases/$base/executer.sh"

commands=("install" "run")

usage() {
  commands_=$(printf "%s\n" ${commands[@]})

  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [OPTIONS] command

Script description here.

Available commands:

${commands_}


Available options:

-h, --help      Print this help and exit
EOF
  exit
}

parse_params() {
  # default values of variables set from params
  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  commands_=$(printf "%s\n" ${commands[@]})
  command="${1-}"
  [[ -z "$command" ]] && die "No command given"
  [[ "${commands_}" =~ .*^"$command"$.* ]] || die "No such command"
  shift

  args=$@

  return 0
}

parse_params "$@"
$command $args
