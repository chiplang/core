const std = @import("std");
const lib = @import("lib");
const File = lib.fs.File;
const testing = std.testing;
const mem = std.mem;

// core/src/lib/fs.zig: `File`
test "File: open(...), close() and next_byte()" {
    if (File.open(&std.fs.cwd(), "src/unit-tests/samples/file", .read_only)) |fd| {
        var file = fd;
        // Content/file management.
        {
            var chunk = [5]u8{ 0, 0, 0, 0, 0 };
            var i: usize = 0;
            while (true) : (i += 1) {
                if (file.peek_byte()) |c| {
                    if (i < 5) {
                        chunk[i] = c;

                        if (i == 4) {
                            try testing.expect(mem.eql(u8, &chunk, "Lorem"));
                        }
                    }
                } else break;
                if (file.next_byte()) |_| {} else |_| try testing.expect(false);
            }
            try testing.expect(i == 18054); // `18054` is the byte size of the sample file.
        }
        file.close();
        try testing.expect(file.fd == null);
    } else |_| try testing.expect(false);
}
