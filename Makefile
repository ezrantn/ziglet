build:
	@zig build

qemu: build
	@qemu-system-x86_64 -cdrom ziglet.iso -monitor stdio