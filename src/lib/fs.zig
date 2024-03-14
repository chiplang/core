const std = @import("std");
const fs = std.fs;
const OpenMode = fs.File.OpenMode;
const OpenError = fs.File.OpenError;
const ReadError = fs.File.ReadError;

/// Buffer switch flag.
const IsBuffer = union(enum(u1)) {
    buf1,
    buf2,
};

/// `1kB`
const bufsize = 1024;
pub const File = struct {
    /// File descriptor.
    fd: ?fs.File = null,

    // Buffers and iters.
    buf1: [bufsize / 2]u8 = undefined,
    buf1_contents_len: usize = 0,
    buf1_i: usize = 0,
    buf2: [bufsize / 2]u8 = undefined,
    buf2_contents_len: usize = 0,
    buf2_i: usize = 0,
    /// Buffer switch flag: `buf1` | `buf2`.
    is_buf: IsBuffer = .buf1,

    const Self = @This();

    /// Open file oriented to the handling of language scripts.
    pub fn open(cwd: *const fs.Dir, sub_path: []const u8, mode: OpenMode) (OpenError || ReadError)!File {
        var file = File{
            .fd = try cwd.openFile(sub_path, .{ .mode = mode }),
        };
        file.buf1_contents_len = try file.fd.?.read(&file.buf1);
        file.buf2_contents_len = try file.fd.?.read(&file.buf2);
        return file;
    }
    /// Deinitializes the stream.
    pub inline fn close(self: *Self) void {
        if (self.fd != null) {
            self.fd.?.close();
            self.fd = null;
            self.buf1 = undefined;
            self.buf1_contents_len = 0;
            self.buf1_i = 0;
            self.buf2 = undefined;
            self.buf2_contents_len = 0;
            self.buf2_i = 0;
        }
    }

    /// Gets the next byte in the file by advancing the position.
    pub fn next_byte(self: *Self) ReadError!?u8 {
        return switch (self.is_buf) {
            .buf1 => blk: {
                // End of buffer.
                if (self.buf1_i >= self.buf1_contents_len) {
                    if (self.buf2_contents_len == 0) return null;
                    self.is_buf = .buf2;

                    // Reset the other buffer and load it with the next chunk in the file.
                    self.buf1_i = 0;
                    self.buf1_contents_len = try self.fd.?.read(&self.buf1);

                    self.buf2_i = 1;
                    break :blk self.buf2[0];
                }

                self.buf1_i += 1;
                break :blk self.buf1[self.buf1_i - 1];
            },
            .buf2 => blk: {
                // End of buffer.
                if (self.buf2_i >= self.buf2_contents_len) {
                    if (self.buf1_contents_len == 0) return null;
                    self.is_buf = .buf1;

                    // Reset the other buffer and load it with the next chunk in the file.
                    self.buf2_i = 0;
                    self.buf2_contents_len = try self.fd.?.read(&self.buf2);

                    self.buf1_i = 1;
                    break :blk self.buf1[0];
                }

                self.buf2_i += 1;
                break :blk self.buf2[self.buf2_i - 1];
            },
        };
    }
};
