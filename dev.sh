#!/bin/bash

function build_and_run {
    echo "Building Ziglet..."
    if ! zig build; then
        echo "Build failed!"
        return 1
    fi

    echo "Updating ISO..."
    cp zig-out/bin/ziglet isodir/boot/
    grub-mkrescue -o ziglet.iso isodir

    echo "Running QEMU..."
    qemu-system-x86_64 -cdrom ziglet.iso -monitor stdio &
    QEMU_PID=$!
}

if [ "$1" = "--watch" ]; then
    mkdir -p .hashes
    while true; do
        for file in src/*.zig; do
            current_hash=$(md5sum "$file")
            filename=$(basename "$file")
            hash_file=".hashes/$filename.hash"
            
            if [ ! -f "$hash_file" ] || [ "$current_hash" != "$(cat "$hash_file")" ]; then
                echo "Change detected in $file"
                echo "$current_hash" > "$hash_file"
                
                if [ ! -z "$QEMU_PID" ]; then
                    kill $QEMU_PID 2>/dev/null
                fi
                
                build_and_run
            fi
        done
        sleep 2
    done
else
    build_and_run
fi