FROM greyltc/archlinux-aur:yay

RUN printf "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

USER ab
RUN yay -Syu --noconfirm
RUN yay -S --noconfirm mesa-utils base-devel

CMD "tail -f /dev/null"