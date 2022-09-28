FROM greyltc/archlinux-aur:yay

USER ab
RUN yay -Syu --noconfirm
RUN yay -S --noconfirm mesa-utils base-devel

CMD "tail -f /dev/null"