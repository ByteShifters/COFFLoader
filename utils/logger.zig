const std = @import("std");

pub const Level = enum { INF, ERR, DBG, SYS };

pub fn log(level: Level, message: []const u8) void {
    const time = std.time.timestamp().@"yyyy-MM-dd HH:mm:ss";
    const prefix = switch (level) {
        .INF => "(INF)",
        .ERR => "(ERR)",
        .DBG => "(DBG)",
        .SYS => "(SYS)",
    };
    std.debug.print("{s} {s} - {s}\n", .{prefix, time, message});
}
