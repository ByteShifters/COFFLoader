const std = @import("std");

pub fn allocateMemory(size: usize) !?*u8 {
    const result = std.os.virtualAlloc(size, std.os.MemProtect.executeReadWrite);
    if (result == null) {
        @import("utils/logger").log(.ERR, "Memory allocation failed");
        return error.OutOfMemory;
    }
    return result;
}

pub fn deallocateMemory(ptr: ?*u8, size: usize) void {
    if (ptr) std.os.virtualFree(ptr, size);
}
