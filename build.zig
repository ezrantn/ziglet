const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.resolveTargetQuery(.{ .cpu_arch = .x86, .os_tag = .freestanding, .abi = .none });

    const optimize = b.standardOptimizeOption(.{});

    const kernel = b.addExecutable(.{
        .name = "ziglet",
        .root_source_file = b.path("src/kernel.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Set specific linker settings for kernel
    kernel.setLinkerScriptPath(b.path("linker.ld"));

    b.installArtifact(kernel);
}
