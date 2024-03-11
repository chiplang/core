const std = @import("std");

/// Path to the main function to build `chip`.
const chip_main = "src/main.zig";
/// Name for the run command in `zig build <cmd>`.
const run_cmd = "run";
/// Name for the test command in `zig build <cmd>`.
const test_cmd = "dev";

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    // Build `chip`.
    {
        // Release.

        const exe = b.addExecutable(.{
            .name = "chip",
            .root_source_file = .{ .path = chip_main },
            .target = target,
            .optimize = .ReleaseFast,
        });
        b.installArtifact(exe);

        // `zig build run -- arg1 arg2 ...`
        const run = b.addRunArtifact(exe);
        run.step.dependOn(b.getInstallStep());
        if (b.args) |args| run.addArgs(args); // `-- arg1 arg2 ...`

        // `zig build --help`
        b.step(run_cmd, "Create executable and run immediately").dependOn(&run.step);

        // Testing/debug.

        // `zig build dev`
        const dev = b.addRunArtifact(b.addTest(.{
            .root_source_file = .{ .path = chip_main },
            .target = target,
            .optimize = .Debug,
        }));
        // `zig build --help`
        b.step(test_cmd, "Create and run a test build").dependOn(&dev.step);
    }
}
