const std = @import("std");
const testing = std.testing;

test "main" {
    _ = @import("lib/fs.zig");

    try std.testing.expect(true);
}
