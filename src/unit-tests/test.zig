//! Unit tests for Zig `lib`.

test {
    // Library.
    _ = @import("lib/fs.zig");

    // Components.
    _ = @import("cwd.zig");
}
