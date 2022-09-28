install_inner() {
  local name=$1
  shift

  local packages=$@

  docker build --tag "distributer-${base}${name}" - <<EOF
FROM "distributer-${base}-base"

RUN yay -Syu --noconfirm
RUN yay -S --noconfirm ${packages}
EOF
}

run_inner() {
  local image=$1
  shift

  local command=$@

  x11docker --quiet --clipboard=yes --gpu --printer --pulseaudio --webcam --network --auto --user=RETAIN "distributer-${base}-${image}" -- "${command}"
}
