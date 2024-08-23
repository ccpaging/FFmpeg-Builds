#!/bin/bash

SCRIPT_REPO="https://github.com/GNOME/librsvg.git"
SCRIPT_COMMIT="3ed19a5f67976d82ef38b69478452a42fbf24bcf"

ffbuild_enabled() {
    return 0
}

ffbuild_dockerbuild() {
    local myconf=(
        --prefix="$FFBUILD_PREFIX"
        --disable-maintainer-mode
        --disable-shared
        --enable-static
    )

    if [[ $TARGET == win* || $TARGET == linux* ]]; then
        myconf+=(
            --host="$FFBUILD_TOOLCHAIN"
        )
    else
        echo "Unknown target"
        return -1
    fi

    ./autogen.sh "${myconf[@]}"
    make -j$(nproc)
    make install
}

ffbuild_configure() {
    echo --enable-librsvg
}

ffbuild_unconfigure() {
    echo --disable-librsvg
}
