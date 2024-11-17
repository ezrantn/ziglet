const std = @import("std");

// Multiboot header constants
const MULTIBOOT_MAGIC = 0x1BADB002;
const MULTIBOOT_FLAGS = (1<<0) | (1<<1);
const MULTIBOOT_CHECKSUM = -(MULTIBOOT_MAGIC + MULTIBOOT_FLAGS);

// Multiboot header structure
export const multiboot_header align(4) linksection(".multiboot") = [_]i32{
    MULTIBOOT_MAGIC,
    MULTIBOOT_FLAGS,
    MULTIBOOT_CHECKSUM,
};

// Export the kernel stack
export var kernel_stack: [16 * 1024]u8 align(16) = undefined;

// VGA buffer constants
const VGA_BUFFER = 0xB8000;
const VGA_WIDTH = 80;
const VGA_HEIGHT = 25;

// VGA color codes
const VgaColor = enum(u4) {
    Black = 0,
    Blue = 1,
    Green = 2,
    Cyan = 3,
    Red = 4,
    Magenta = 5,
    Brown = 6,
    LightGray = 7,
    DarkGray = 8,
    LightBlue = 9,
    LightGreen = 10,
    LightCyan = 11,
    LightRed = 12,
    LightMagenta = 13,
    Yellow = 14,
    White = 15,
};

// Create VGA entry from character and color
fn vgaEntry(char: u8, fg: VgaColor, bg: VgaColor) u16 {
    const color = @as(u8, @intFromEnum(fg)) | (@as(u8, @intFromEnum(bg)) << 4);
    return @as(u16, char) | (@as(u16, color) << 8);
}

// Kernel entry point
export fn _start() callconv(.Naked) noreturn {
    // Set up stack pointer
    asm volatile (
        \\.section .text
        \\jmp _start32
        
        \\.align 4
        \\.code32
        \\_start32:
        \\  // Set up stack
        \\  mov $(kernel_stack + 16384), %esp
        \\
        \\  // Clear interrupts
        \\  cli
        \\
        \\  // Call kernel main
        \\  call kernel_main
        \\
        \\1:
        \\  hlt
        \\  jmp 1b
    );

    // Halt the CPU
    while (true) {
        asm volatile ("hlt");
    }
}

// Main kernel function
export fn kernel_main() void {
    // Write welcome message to VGA buffer
    const message = "Welcome to Ziglet!";
    var vga = @as([*]volatile u16, @ptrFromInt(VGA_BUFFER));

    for (message, 0..) |char, i| {
        vga[i] = vgaEntry(char, .White, .Black);
    }
}