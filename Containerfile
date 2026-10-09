FROM quay.io/almalinuxorg/atomic-desktop-kde

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
