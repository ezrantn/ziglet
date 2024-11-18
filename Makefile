build:
	@zig build

create-iso:
	@./dev.sh

qemu: build
	@qemu-system-x86_64 -cdrom ziglet.iso -monitor stdio