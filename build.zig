const std = @import("std");

const frontend = "chip";
/// Zig library.
const libname = "lib";

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    // Zig library.
    const lib = b.addModule(libname, .{ .source_file = .{ .path = "src/lib/lib.zig" } });

    // Build `chip`.
    {
        // Release.

        const exe = b.addExecutable(.{
            .name = frontend,
            .root_source_file = .{ .path = "src/main.zig" },
            .target = target,
            .optimize = .ReleaseFast,
        });
        b.installArtifact(exe);

        // `zig build run_chip -- arg1 arg2 ...`
        const run = b.addRunArtifact(exe);
        run.step.dependOn(b.getInstallStep());
        if (b.args) |args| run.addArgs(args); // `-- arg1 arg2 ...`

        b.step( // `zig build --help`
            "run_" ++ frontend,
            "Create executable and run immediately",
        ).dependOn(&run.step);

        exe.addModule(libname, lib); // Add library.

        // Testing/debug.

        // `zig build test_chip`
        const unit_tests = b.addTest(.{
            .root_source_file = .{ .path = "src/unit-tests/test.zig" },
            .target = target,
            .optimize = .Debug,
        });
        const testing = b.addRunArtifact(unit_tests);
        b.step( // `zig build --help`
            "test_" ++ frontend,
            "Create and run a test build",
        ).dependOn(&testing.step);

        unit_tests.addModule(libname, lib); // Add library.
    }
}
