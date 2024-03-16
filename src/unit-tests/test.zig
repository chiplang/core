//! Unit tests for Zig `lib`.

test {
    // Library.
    _ = @import("lib/fs.zig");

    _ = @import("cwd.zig");
}
