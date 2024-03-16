const std = @import("std");
const fs = std.fs;
const OpenError = fs.Dir.OpenError;

/// Code directory.
pub const src = "src";
/// Hidden directory of building resources.
pub const cache = ".cache";
/// Output directory (executable).
pub const target = "target";

/// The current working directory for the builds.
pub const Cwd = struct {
    /// Current working directory.
    cwd: fs.Dir = undefined,
    /// Code directory.
    src: fs.Dir = undefined,
    /// Hidden directory of building resources.
    cache: fs.Dir = undefined,
    /// Output directory (executable).
    target: fs.Dir = undefined,

    const Self = @This();

    /// Opens the stream for the `cwd` directory and its subdirectories.
    pub fn open(cwd: fs.Dir) !Self {
        return .{
            .src = try cwd.makeOpenPath(src, .{ .iterate = true }),
            .cache = try cwd.makeOpenPath(cache, .{ .iterate = true }),
            .target = try cwd.makeOpenPath(target, .{ .iterate = true }),
            .cwd = cwd,
        };
    }
    /// Deinitializes the stream.
    pub fn close(self: *Self) void {
        self.cwd.close();
        self.src.close();
        self.cache.close();
        self.target.close();
    }
};
