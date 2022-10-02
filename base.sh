not_implemented() {
  die "Not Implemented"
}

install_inner() {
  not_implemented
}

install() {
  usage() {
    cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") install [OPTIONS] package1 [package2...]

Script description here.

Available options:

-n, --name      New image name
-h, --help      Print this help and exit
EOF
    exit
  }

  parse_params() {
    # default values of variables set from params
    name=""

    while :; do
      case "${1-}" in
      -n | --name)
        name="-${2-}"
        shift
        ;;
      -h | --help) usage ;;
      -?*) die "Unknown option: $1" ;;
      *) break ;;
      esac
      shift
    done

    packages="$@"

    if [ "$name" = "" ]; then
      name=$(printf -- "-%s" ${packages[@]})
    fi

    return 0
  }

  parse_params "$@"
  install_inner "$name" "$packages"
}

run_inner() {
  not_implemented
}

run() {
  usage() {
    cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") run [OPTIONS] image command

Script description here.

Available options:

-s, --share     Share host file or folder
-v, --verbose   Verbose execution
-h, --help      Print this help and exit
EOF
    exit
  }

  parse_params() {
    # default values of variables set from params
    verbose=false
    extra_args=""

    while :; do
      case "${1-}" in
      -s | --share)
        extra_args="${extra_args} --share=${2-}"
        shift
        ;;
      -v | --verbose) verbose=true ;;
      -h | --help) usage ;;
      -?*) die "Unknown option: $1" ;;
      *) break ;;
      esac
      shift
    done

    if ! $verbose
    then
      extra_args="${extra_args} --quiet"
    fi

    image="${1-}"
    [[ -z "${image-}" ]] && die "Missing required parameter: image"
    shift

    command="$@"
    [[ -z "${command-}" ]] && die "Missing required parameter: command"

    return 0
  }

  parse_params "$@"
  run_inner "$image" "$command"
}
