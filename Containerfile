FROM quay.io/almalinuxorg/atomic-desktop-kde

COPY myos-logo-icon.png myos-logo-icon.svg \
     myos-logo-icon-square.png myos-logo-icon-square.svg \
     myos-logo-icon-small.png \
     myos-logo-icon.ico myos-logo-icon.icns \
     /usr/share/myos-logos/

RUN set -eux; \
    find /usr/share \( -name 'fedora-logo-icon.png' -o -name 'system-logo-icon.png' \) \
        -exec ln -sf /usr/share/myos-logos/myos-logo-icon-square.png {} \; ; \
    for f in /usr/share/almalinux-logos/*.svg; do \
        ln -sf /usr/share/myos-logos/myos-logo-icon.svg "$f"; \
    done; \
    find /usr/share/pixmaps \
        \( -name 'fedora-logo-sprite.png' -o -name 'bootlogo_128.png' \
        -o -name 'bootlogo_256.png' \) \
        -exec ln -sf /usr/share/myos-logos/myos-logo-icon-square.png {} \; ; \
    find /usr/share/pixmaps \
        \( -name 'fedora-logo.png' -o -name 'fedora-logo-small.png' \
        -o -name 'system-logo-white.png' \) \
        -exec ln -sf /usr/share/myos-logos/myos-logo-icon.png {} \; ; \
    find /usr/share/pixmaps -name 'fedora-gdm-logo.png' \
        -exec ln -sf /usr/share/myos-logos/myos-logo-icon-small.png {} \; ; \
    find /usr/share/pixmaps -name 'fedora-logo-sprite.svg' \
        -exec ln -sf /usr/share/myos-logos/myos-logo-icon-square.svg {} \; ; \
    find /usr/share/pixmaps -name 'fedora-logo.ico' \
        -exec ln -sf /usr/share/myos-logos/myos-logo-icon.ico {} \; ; \
    find /usr/share/pixmaps -name 'fedora.icns' \
        -exec ln -sf /usr/share/myos-logos/myos-logo-icon.icns {} \; ; \
    ln -sf /usr/share/myos-logos/myos-logo-icon-square.svg \
        /usr/share/icons/hicolor/scalable/apps/start-here.svg; \
    find /usr/share/plymouth -name 'watermark.png' \
        -exec ln -sf /usr/share/myos-logos/myos-logo-icon-small.png {} \; ; \
    gtk-update-icon-cache -f -q /usr/share/icons/hicolor

RUN set -eux; \
    f=/usr/lib/os-release; \
    sed -i \
        -e 's/^NAME="AlmaLinux"/NAME="MyOS"/' \
        -e 's/^PRETTY_NAME="AlmaLinux /PRETTY_NAME="MyOS /' \
        -e 's/^ID="almalinux"/ID="myos"/' \
        -e 's/^ID_LIKE="rhel centos fedora"/ID_LIKE="almalinux rhel centos fedora"/' \
        -e 's/^VENDOR_NAME="AlmaLinux"/VENDOR_NAME="MyOS"/' \
        -e 's/10\.2/10/g' \
        -e 's/ ([^)]*)"/"/g' \
        -e 's#^\(HOME_URL\|DOCUMENTATION_URL\|VENDOR_URL\|BUG_REPORT_URL\)="https://[^"]*"#\1="https://example.com/"#' \
        -e 's#cpe:/o:almalinux:almalinux:#cpe:/o:myos:myos:#' \
        -e 's/^ALMALINUX_/MYOS_/' \
        -e 's/^MYOS_MANTISBT_PROJECT="AlmaLinux-10"/MYOS_MANTISBT_PROJECT="MyOS-10"/' \
        -e 's/^REDHAT_SUPPORT_PRODUCT="AlmaLinux"/REDHAT_SUPPORT_PRODUCT="MyOS"/' \
        -e '/^VARIANT_ID=/d' \
        "$f"
