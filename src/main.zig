const std = @import("std");
const lib = @import("lib");

pub fn main() !void {
    const cwd = try @import("cwd.zig").Cwd.open(std.fs.cwd());
    try @import("buildsys/buildsys.zig").buildsys(&cwd.src);

    //var file = try lib.fs.File.open(
    //&std.fs.cwd(),
    //"src/unit-tests/samples/file",
    //.read_only,
    //);
    //defer file.close();

    //var string = std.ArrayList(u8).init(std.heap.page_allocator);
    //defer string.deinit();
    //var i: usize = 0;
    //while (file.peek_byte()) |c| : (i += 1) {
    //try string.append(c);
    //_ = try file.next_byte();
    //}
    //std.debug.print("{s}:{d}", .{ string.items, i });
}
