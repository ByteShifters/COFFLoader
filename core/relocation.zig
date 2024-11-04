const std = @import("std");
const Memory = @import("utils/memory");

pub const RelocationEntry = packed struct {
    VirtualAddress: u32,
    SymbolTableIndex: u32,
    Type: u16,
};

pub fn applyRelocations(baseAddr: *u8, relocations: []RelocationEntry, sectionOffset: u32) !void {
    for (relocations) |reloc| {
        const targetAddress = baseAddr + sectionOffset + reloc.VirtualAddress;
        const target = @ptrCast(*u32, targetAddress);
        switch (reloc.Type) {
            0x06 => |IMAGE_REL_AMD64_ADDR32| {
                *target += @intCast(u32, baseAddr);
            },
            else => @import("utils/logger").log(.ERR, "Unsupported relocation type"),
        }
    }
}
