const std = @import("std");
const fs = std.fs;

/// C/C++ build system based on the `src/` directory walk.
pub fn buildsys(src: *fs.Dir) !void {
    var dir = try src.openIterableDir("", .{});
    var walker = try dir.walk(std.heap.page_allocator);
    walker.next();
}
