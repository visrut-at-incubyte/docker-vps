FROM archlinux:base

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm openssh && \
    pacman -Scc --noconfirm

RUN ssh-keygen -A

RUN echo 'root:root' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 2222
CMD ["/usr/sbin/sshd", "-D", "-e", "-p", "2222"]
