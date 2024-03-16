const std = @import("std");
const fs = std.fs;
const OpenMode = fs.File.OpenMode;
const OpenError = fs.File.OpenError;
const ReadError = fs.File.ReadError;

pub const File = struct {
    const Self = @This();

    /// File descriptor.
    fd: ?fs.File = null,

    // Buffers and iters.
    buf1: [bufsize]u8 = undefined,
    buf1_content_len: usize = 0,
    buf1_i: usize = 0,
    buf2: [bufsize]u8 = undefined,
    buf2_content_len: usize = 0,
    buf2_i: usize = 0,
    /// Buffer switch flag: `buf1` | `buf2`.
    is_buf: IsBuffer = .buf1,

    /// `1kB`
    const bufsize = 1024;
    /// Buffer switch flag.
    const IsBuffer = union(enum(u1)) {
        buf1,
        buf2,
    };

    /// Open file oriented to the handling of language scripts.
    pub fn open(cwd: *const fs.Dir, sub_path: []const u8, mode: OpenMode) (OpenError || ReadError)!File {
        var file = File{
            .fd = try cwd.openFile(sub_path, .{ .mode = mode }),
        };
        file.buf1_content_len = try file.fd.?.read(&file.buf1);
        file.buf2_content_len = try file.fd.?.read(&file.buf2);
        return file;
    }
    /// Deinitializes the stream.
    pub inline fn close(self: *Self) void {
        if (self.fd != null) {
            self.fd.?.close();
            self.fd = null;
            self.buf1 = undefined;
            self.buf1_i = 0;
            self.buf1_content_len = 0;
            self.buf2 = undefined;
            self.buf2_i = 0;
            self.buf2_content_len = 0;
        }
    }

    /// Gets the next byte in the file without advancing position.
    pub inline fn peek_byte(self: Self) ?u8 {
        return switch (self.is_buf) {
            .buf1 => buf1: {
                if (self.buf1_i >= self.buf1_content_len) { // The next/other buffer.
                    if (self.buf2_content_len == 0) return null;
                    break :buf1 self.buf2[0];
                }
                break :buf1 self.buf1[self.buf1_i];
            },
            .buf2 => buf2: {
                if (self.buf2_i >= self.buf2_content_len) { // The next/other buffer.
                    if (self.buf1_content_len == 0) return null;
                    break :buf2 self.buf1[0];
                }
                break :buf2 self.buf2[self.buf2_i];
            },
        };
    }

    /// Gets the next byte in the file by advancing the position.
    pub fn next_byte(self: *Self) ReadError!?u8 {
        return switch (self.is_buf) {
            .buf1 => buf1: {
                // End of buffer (1).
                if (self.buf1_i >= self.buf1_content_len) {
                    if (self.buf2_content_len == 0) return null;
                    self.is_buf = .buf2;

                    // Reset the other buffer and load it with the next chunk in the file.
                    self.buf1_i = 0;
                    self.buf1_content_len = try self.fd.?.read(&self.buf1);

                    self.buf2_i = 1;
                    break :buf1 self.buf2[0];
                }

                self.buf1_i += 1;
                break :buf1 self.buf1[self.buf1_i - 1];
            },
            .buf2 => buf2: {
                // End of buffer (2).
                if (self.buf2_i >= self.buf2_content_len) {
                    if (self.buf1_content_len == 0) return null;
                    self.is_buf = .buf1;

                    // Reset the other buffer and load it with the next chunk in the file.
                    self.buf2_i = 0;
                    self.buf2_content_len = try self.fd.?.read(&self.buf2);

                    self.buf1_i = 1;
                    break :buf2 self.buf1[0];
                }

                self.buf2_i += 1;
                break :buf2 self.buf2[self.buf2_i - 1];
            },
        };
    }
};
