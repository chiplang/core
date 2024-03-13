const std = @import("std");
const lib = @import("lib");
const File = lib.fs.File;
const testing = std.testing;

// core/src/lib/fs.zig: `File`
test "File: open(...) and close()" {
    if (File.open(&std.fs.cwd(), "LICENSE", .read_only)) |fd| {
        var file = fd;
        file.close();
        try testing.expect(file.fd == null);
    } else |_| try testing.expect(false);
}
