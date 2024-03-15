const std = @import("std");
const testing = std.testing;
const cwd = @import("cwd");
const fs = std.fs;
const mem = std.mem;

// core/src/cwd.zig: `Cwd`
test "Cwd: open(...), close(), src, cache and target" {
    if (cwd.Cwd.open(fs.cwd())) |d| {
        var dir = d;
        dir.close();

        // Literals.
        try testing.expect(mem.eql(u8, cwd.src, "src"));
        try testing.expect(mem.eql(u8, cwd.cache, ".cache"));
        try testing.expect(mem.eql(u8, cwd.target, "target"));
    } else |_| try testing.expect(false);
}
