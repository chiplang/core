const std = @import("std");
const fs = std.fs;
const OpenMode = fs.File.OpenMode;
const OpenError = fs.File.OpenError;

pub const File = struct {
    /// File descriptor.
    fd: ?fs.File = null,
    buf: [1024]u8 = undefined,
    /// If it exists, get the next byte at the end of the buffer without advancing.
    peek_byte: u8 = undefined,

    const Self = @This();

    /// Open file oriented to the handling of language scripts.
    pub fn open(cwd: *const fs.Dir, sub_path: []const u8, mode: OpenMode) OpenError!File {
        return File{
            .fd = try cwd.openFile(sub_path, .{ .mode = mode }),
            .buf = undefined,
            .peek_byte = undefined,
        };
    }
    /// Deinitializes the stream.
    pub inline fn close(self: *Self) void {
        if (self.fd != null) {
            self.fd.?.close();
            self.fd = null;
        }
    }
};
