install_inner() {
  local name=$1
  shift

  local packages=$@

  docker build --no-cache --tag "distributer-${base}${name}" - <<EOF
FROM "distributer-${base}-base"

RUN yay -Syu --noconfirm
RUN yay -S --noconfirm ${packages}
EOF
}

run_inner() {
  local image=$1
  shift

  local command=$@

  x11docker --stdin --clipboard=yes --sudouser --gpu --printer --pulseaudio --webcam --network --auto --user=RETAIN "distributer-${base}-${image}" -- ${command}
}
