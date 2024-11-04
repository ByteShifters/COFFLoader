const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable("COFFLoader", "entry/main.zig");
    exe.addIncludePath("core");
    exe.addIncludePath("utils");
    exe.setBuildMode(b.standardReleaseOptions());
    exe.install();
}
