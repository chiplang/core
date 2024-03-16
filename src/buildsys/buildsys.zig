const std = @import("std");
const fs = std.fs;
const Dir = fs.Dir;
const process = std.process;
const Thread = std.Thread;

/// C/C++ build system based on the `src/` directory walk.
pub fn buildsys(src: *const fs.Dir) (Dir.Iterator.Error || Thread.SpawnError ||
    Dir.OpenError)!void {
    var iter = src.iterate();
    while (try iter.next()) |entry| {
        switch (entry.kind) {
            .directory => {
                var subdir = try src.openDir(entry.name, .{ .iterate = true });
                defer subdir.close();

                const thread = try Thread.spawn(
                    .{
                        .allocator = null,
                        .stack_size = 16 * 1024, // 16kB
                    },
                    buildsys,
                    .{subdir},
                );
            },
            .file => {
                //const argv = [_][]const u8{};
                //_ = process.Child.init(&argv, std.heap.page_allocator);
                std.debug.print("{s}\n", .{entry.name});
            },
            else => {},
        }
    }
}
