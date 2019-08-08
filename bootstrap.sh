#!/bin/bash

BUILD_DIR=$(pwd)/build
VENDOR_DIR=$(pwd)/vendor
LOG_DIR="$BUILD_DIR/$NGINX_DIR/logs"

NGINX_DIR=nginx
NGINX_VERSION=1.17.1

function setup() {
    echo "[+] Prepared to create local directories if needed"
    if [ ! -d $BUILD_DIR ]; then
        mkdir -p $BUILD_DIR/$NGINX_DIR
        echo "[+] Created directory $BUILD_DIR/$NGINX_DIR"
    fi
    if [ ! -d $VENDOR_DIR ]; then
        mkdir $VENDOR_DIR
        echo "[+] Created directory $VENDOR_DIR"
    fi
    echo "[+] Finish setup"
}

function download_nginx() {
    echo "[+] Prepared to download nginx $NGINX_VERSION"
    if [ ! -d "$VENDOR_DIR/nginx-$NGINX_VERSION" ]; then
        curl -s -L -o "$VENDOR_DIR/nginx-$NGINX_VERSION.tar.gz" "http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz"
        echo "[+] Nginx downloaded to $VENDOR_DIR/nginx-$NGINX_VERSION.tar.gz"
        tar xzf "$VENDOR_DIR/nginx-$NGINX_VERSION.tar.gz" -C $VENDOR_DIR
        rm -rf "$VENDOR_DIR/nginx-$NGINX_VERSION.tar.gz"
    fi
    echo "[+] Nginx v$NGINX_VERSION downloaded"
}

function install_nginx() {
    echo "[+] Prepared to install nginx v$NGINX_VERSION"
    if [ -d "$BUILD_DIR/$NGINX_DIR/sbin" ]; then
        echo "[+] Nginx v$NGINX_VERSION is already installed in $BUILD_DIR/$NGINX_DIR"
        exit 1
    fi
    pushd $VENDOR_DIR/nginx-$NGINX_VERSION
    ./configure --with-debug \
        --prefix=$BUILD_DIR/$NGINX_DIR \
        --error-log-path="$LOG_DIR/error.log"
        --http-log-path="$LOG_DIR/access.log"
    make
    make install
    popd
    echo "[+] Finished nginx installation"
}

function create_config_symlink() {
    ln -sf "$(pwd)/conf/nginx.conf" "$BUILD_DIR/$NGINX_DIR/conf/nginx.conf"
}

setup
download_nginx
install_nginx
create_config_symlink
