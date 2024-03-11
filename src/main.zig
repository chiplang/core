const std = @import("std");

pub fn main() void {
    std.debug.print("Hello, world!\n", .{});
}
test "dev" {
    std.debug.print("Hello, world!\n", .{});
}
